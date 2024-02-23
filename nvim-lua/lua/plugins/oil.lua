return {
  'stevearc/oil.nvim',
  config = function ()
    local oil = require("oil")

    -- TODO Configure float to look like fzf-lua
    oil.setup({ })

    -- keymaps
    vim.keymap.set('n', '<leader>nf', oil.toggle_float, { desc = '[N]avigate [F]iles' })
  end
}
