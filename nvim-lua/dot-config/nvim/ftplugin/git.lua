-- readonly buffers are likely things like git-logs
if not vim.bo.modifiable then
  vim.opt.spell = false
end
