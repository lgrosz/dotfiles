-- *.pg files are postgres SQL
vim.filetype.add({ extension = { pg = 'sql' } })

-- close the buffer once its terminal exits
vim.api.nvim_create_autocmd('TermClose', {
  callback = function() vim.cmd('bdelete') end,
})

-- Reclaim horizontal space in diff windows (e.g. fugitive's `dv`): the diff
-- highlighting already shows the changes, so the sign column is just noise.
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'diff',
  callback = function()
    vim.opt_local.signcolumn = vim.v.option_new == '1' and 'no' or 'auto'
  end,
})

-- :Scratch — throwaway unlisted buffer
vim.api.nvim_create_user_command('Scratch', function()
  vim.cmd('enew')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'hide'
  vim.bo.swapfile = false
end, {})
