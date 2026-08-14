require('fzf-lua').setup({
  fzf_colors = true,
})

-- edit the filesystem as a buffer
require('oil').setup()
vim.keymap.set('n', '<leader>nf', require('oil').toggle_float, { desc = '[N]avigate [F]iles' })

require('gitsigns').setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gs = require('gitsigns')
    vim.keymap.set('n', '[h', gs.prev_hunk, { buffer = bufnr, desc = 'Go to previous [h]unk' })
    vim.keymap.set('n', ']h', gs.next_hunk, { buffer = bufnr, desc = 'Go to next [h]unk' })
    vim.keymap.set('n', '<localleader>hp', gs.preview_hunk, { buffer = bufnr, desc = '[H]unk [p]review' })
    vim.keymap.set('n', '<localleader>hs', gs.stage_hunk, { buffer = bufnr, desc = '[H]unk [s]tage' })
    vim.keymap.set('n', '<localleader>hr', gs.reset_hunk, { buffer = bufnr, desc = '[H]unk [r]eset' })
  end,
})
