vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.pack.add({
  'https://github.com/ibhagwan/fzf-lua',
})

local fzf_lua = require('fzf-lua')

fzf_lua.setup({
  fzf_colors = true,
})

vim.keymap.set('n', '<leader>sf', fzf_lua.files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sb', fzf_lua.buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sg', fzf_lua.grep_project, { desc = '[S]earch with [G]rep' })
vim.keymap.set('n', '<leader>sw', fzf_lua.grep_cword, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>s:', fzf_lua.commands, { desc = '[S]earch commands' })
vim.keymap.set('n', '<leader>sh:', fzf_lua.command_history, { desc = '[S]earch [H]istory of commands' })
vim.keymap.set('n', '<leader>sh/', fzf_lua.search_history, { desc = '[S]earch [H]istory of searches' })
vim.keymap.set("n", "<leader>gf", fzf_lua.git_files, { desc = 'Search [G]it [F]iles' })

