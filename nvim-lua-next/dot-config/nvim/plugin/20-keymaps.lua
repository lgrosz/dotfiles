-- Search for things
vim.keymap.set('n', '<leader>sf', '<Cmd>lua require("fzf-lua").files()<CR>', { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sb', '<Cmd>lua require("fzf-lua").buffers()<CR>', { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sg', '<Cmd>lua require("fzf-lua").grep_project()<CR>', { desc = '[S]earch with [G]rep' })
vim.keymap.set('n', '<leader>sw', '<Cmd>lua require("fzf-lua").grep_cword()<CR>', { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>s:', '<Cmd>lua require("fzf-lua").commands()<CR>', { desc = '[S]earch commands' })
vim.keymap.set('n', '<leader>sh:', '<Cmd>lua require("fzf-lua").command_history()<CR>', { desc = '[S]earch [H]istory of commands' })
vim.keymap.set('n', '<leader>sh/', '<Cmd>lua require("fzf-lua").search_history()<CR>', { desc = '[S]earch [H]istory of searches' })
vim.keymap.set("n", "<leader>gf", '<Cmd>lua require("fzf-lua").git_files()<CR>', { desc = 'Search [G]it [F]iles' })

