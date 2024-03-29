return {
  'stevearc/oil.nvim',
  config = function ()
    local oil = require("oil")

    -- keymaps
    vim.keymap.set('n', '<leader>nf', oil.toggle_float, { desc = '[N]avigate [F]iles' })
  end
}
