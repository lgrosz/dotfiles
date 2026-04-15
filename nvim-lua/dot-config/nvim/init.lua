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

-- Install plugins
require('lazy').setup({
	{ import = 'plugins' },
})

vim.keymap.set('i', 'fd', '<Esc>')

vim.api.nvim_create_user_command('Scratch', require'tools'.makeScratch, {})
vim.opt.splitright = true

-- Diagnostic keymaps
-- See :diagnostic-defaults
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Setup keymaps, but only after language sever attached to the current buffer.
-- These are just the default bindings that nvim-lspconfig has in their readme
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  end,
})

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
