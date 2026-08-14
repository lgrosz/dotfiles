require('nvim-treesitter').install('python')

vim.lsp.enable('pyright')

if vim.treesitter.language.add('python') then
  vim.treesitter.start()

  -- use neovim treesitter folding
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.wo.foldmethod = 'expr'

  -- nvim-treesitter provides indent queries
  if vim.tbl_contains(require('nvim-treesitter').get_installed('queries'), 'python') then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end
