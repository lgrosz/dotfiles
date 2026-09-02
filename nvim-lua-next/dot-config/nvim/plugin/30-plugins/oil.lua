-- edit the filesystem as a buffer
require('oil').setup()

vim.keymap.set('n', '<leader>nf', function() require('oil').toggle_float() end, { desc = '[N]avigate [F]iles' })
