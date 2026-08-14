-- readonly buffers are likely things like git-logs
if not vim.bo.modifiable then
  vim.wo[0][0].spell = false
end
