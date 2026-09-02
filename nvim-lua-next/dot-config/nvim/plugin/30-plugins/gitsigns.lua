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
    vim.keymap.set('n', '[h', function() gs.nav_hunk('prev') end, { buffer = bufnr, desc = 'Go to previous [h]unk' })
    vim.keymap.set('n', ']h', function() gs.nav_hunk('next') end, { buffer = bufnr, desc = 'Go to next [h]unk' })
    vim.keymap.set('n', '<localleader>hp', gs.preview_hunk, { buffer = bufnr, desc = '[H]unk [p]review' })
    vim.keymap.set('n', '<localleader>hs', gs.stage_hunk, { buffer = bufnr, desc = '[H]unk [s]tage' })
    vim.keymap.set('n', '<localleader>hr', gs.reset_hunk, { buffer = bufnr, desc = '[H]unk [r]eset' })
  end,
})
