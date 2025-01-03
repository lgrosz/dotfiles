return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    local fzf_lua = require("fzf-lua")
    fzf_lua.setup({ })

    -- keymaps
    vim.keymap.set('n', '<leader>sf', fzf_lua.files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sb', fzf_lua.buffers, { desc = '[S]earch [B]uffers' })
    vim.keymap.set('n', '<leader>sg', fzf_lua.grep_project, { desc = '[S]earch with [G]rep' })
    vim.keymap.set('n', '<leader>sw', fzf_lua.grep_cword, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>s:', fzf_lua.commands, { desc = '[S]earch commands' })
    vim.keymap.set('n', '<leader>sh/', fzf_lua.command_history, { desc = '[S]earch [H]istory of commands' })
    vim.keymap.set('n', '<leader>sh:', fzf_lua.search_history, { desc = '[S]earch [H]istory of searches' })

    vim.keymap.set("n", "<leader>gf", fzf_lua.git_files, { silent = true, desc = 'Search [G]it [F]iles' })

    fzf_lua.register_ui_select()
  end,
}

