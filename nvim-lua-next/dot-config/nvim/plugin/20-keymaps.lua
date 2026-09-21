-- Search for things
vim.keymap.set('n', '<leader>sf', function() require('fzf-lua').files() end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sb', function() require('fzf-lua').buffers() end, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sg', function() require('fzf-lua').grep_project() end, { desc = '[S]earch with [G]rep' })
vim.keymap.set('n', '<leader>sw', function() require('fzf-lua').grep_cword() end, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>s:', function() require('fzf-lua').commands() end, { desc = '[S]earch commands' })
vim.keymap.set('n', '<leader>sh:', function() require('fzf-lua').command_history() end, { desc = '[S]earch [H]istory of commands' })
vim.keymap.set('n', '<leader>sh/', function() require('fzf-lua').search_history() end, { desc = '[S]earch [H]istory of searches' })
vim.keymap.set('n', '<leader>gf', function() require('fzf-lua').git_files() end, { desc = 'Search [G]it [F]iles' })

