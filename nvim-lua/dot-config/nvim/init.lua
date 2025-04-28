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
