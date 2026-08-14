vim.diagnostic.config({
  severity_sort = true,
  underline = true,
  virtual_text = true,
  -- letters, not icons (matches the no-icons aesthetic)
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'E',
      [vim.diagnostic.severity.WARN] = 'W',
      [vim.diagnostic.severity.INFO] = 'I',
      [vim.diagnostic.severity.HINT] = 'H',
    },
  },
})
