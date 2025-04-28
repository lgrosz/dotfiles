-- Set <,> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- TODO Many stuff in this file needs to be delegated to the appropriate
-- granular configuration file

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Global helper functions
function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Install plugins
require('lazy').setup({
	{ import = 'plugins' },
})

map('i', 'fd', '<Esc>')

vim.api.nvim_create_user_command('Scratch', require'tools'.makeScratch, {})
vim.opt.splitright = true

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Setup keymaps, but only after language sever attached to the current buffer.
-- These are just the default bindings that nvim-lspconfig has in their readme
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)

    vim.api.nvim_set_keymap('v', '<leader>f', ':lua vim.lsp.buf.format({ range = {["start"] = vim.api.nvim_buf_get_mark(0, "<"), ["end"] = vim.api.nvim_buf_get_mark(0, ">")} })<CR>', { noremap = true, silent = true })
  end,
})

local function get_changed_lines()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(bufnr)
  if file == "" then return nil end -- Unsaved buffer

  local cmd = string.format("git diff --unified=0 %s", vim.fn.shellescape(file))
  local output = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then return nil end

  local ranges = {}
  for _, line in ipairs(output) do
    local start, count = line:match("@@ %-%d+,%d+ %+(%d+),?(%d*) @@")
    if start then
      start = tonumber(start)
      count = count ~= "" and tonumber(count) or 1
      table.insert(ranges, { start, start + count - 1 })
    end
  end

  return ranges
end

local function format_changed_lines()
  local ranges = get_changed_lines()
  if not ranges or #ranges == 0 then return end

  for _, range in ipairs(ranges) do
    vim.lsp.buf.format({
      range = { start = { range[1], 0 }, ["end"] = { range[2], 0 } },
      async = true,
    })
  end
end

vim.api.nvim_create_user_command("FormatChanged", format_changed_lines, {})

-- Close buffer after terminal exists
vim.api.nvim_create_autocmd("TermClose", {
    callback = function()
       vim.cmd("bdelete")
    end
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  pattern = {"*.pg"},
  callback = function()
    vim.bo.filetype = "sql"
  end
})

-- LLM commit messages
-- File: lua/generate_commit_message.lua
local M = {}

-- You can configure your API endpoint and key here
local api_url = "https://api.openai.com/v1/chat/completions"
local api_key = os.getenv("OPENAI_API_KEY") -- set this environment variable securely

local function get_git_diff()
  -- Get the staged git diff
  local handle = io.popen("git diff --cached")
  if not handle then return nil end

  local result = handle:read("*a")
  handle:close()
  return result
end

local function generate_commit_message(diff, callback)
  local curl = require("plenary.curl")

  local body = {
    model = "gpt-4", -- or "gpt-3.5-turbo"
    messages = {
      { role = "system", content = "You are a helpful assistant that writes concise git commit messages based on diffs." },
      { role = "user", content = "Generate a commit message for the following diff:\n" .. diff },
    },
    temperature = 0.5,
  }

  curl.post(api_url, {
    headers = {
      ["Content-Type"] = "application/json",
      ["Authorization"] = "Bearer " .. api_key,
    },
    body = vim.fn.json_encode(body),
    callback = function(response)
      if response.status ~= 200 then
        vim.notify("Failed to generate commit message: " .. (response.body or "Unknown error"), vim.log.levels.ERROR)
        return
      end

      local parsed = vim.fn.json_decode(response.body)
      local message = parsed.choices[1].message.content

      if callback then
        callback(message)
      end
    end
  })
end

local function insert_commit_message(message)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(message, "\n"))
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.notify("Hello world!", vim.log.levels.WARN)
    local diff = get_git_diff()

    if not diff or diff == "" then
      vim.notify("No staged changes to generate commit message from.", vim.log.levels.WARN)
      return
    end

    generate_commit_message(diff, function(message)
      insert_commit_message(message)
      vim.notify("Generated commit message inserted.", vim.log.levels.INFO)
    end)
  end,
})
