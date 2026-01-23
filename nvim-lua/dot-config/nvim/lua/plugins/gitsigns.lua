return	{
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  'lewis6991/gitsigns.nvim',
  opts = {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
    changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      vim.keymap.set('n', '[h', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to previous [h]unk' })
      vim.keymap.set('n', ']h', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to next [h]unk' })
      vim.keymap.set('n', '<localleader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[H]unk [p]review' })
      vim.keymap.set('n', '<localleader>hs', require('gitsigns').stage_hunk, { buffer = bufnr, desc = '[H]unk [s]tage' })
      vim.keymap.set('n', '<localleader>hr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = '[H]unk [r]eset' })
    end,
  },
}

