-- *.pg files are postgres SQL
vim.filetype.add({ extension = { pg = 'sql' } })

-- close the buffer once its terminal exits. Delete ev.buf explicitly: the
-- terminal is often not the current buffer when it exits, and a bare
-- :bdelete would take out whichever buffer happens to be focused instead.
vim.api.nvim_create_autocmd('TermClose', {
  callback = function(ev) vim.api.nvim_buf_delete(ev.buf, { force = true }) end,
})

-- Reclaim horizontal space in diff windows (e.g. fugitive's `dv`): the diff
-- highlighting already shows the changes, so the sign column is just noise.
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'diff',
  callback = function()
    -- v:option_new is a boolean for a boolean option, never the string '1'
    if vim.v.option_new then
      vim.w.signcolumn_prediff = vim.wo.signcolumn
      vim.wo[0][0].signcolumn = 'no'
    else
      vim.wo[0][0].signcolumn = vim.w.signcolumn_prediff or vim.go.signcolumn
      vim.w.signcolumn_prediff = nil
    end
  end,
})

-- :Scratch — throwaway unlisted buffer
vim.api.nvim_create_user_command('Scratch', function()
  vim.cmd('enew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'hide'
  vim.bo.swapfile = false
end, {})
