require('nvim-treesitter').install('c')

vim.lsp.enable('clangd')

if vim.treesitter.language.add('c') then
  vim.treesitter.start()

  -- use neovim treesitter folding
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.wo.foldmethod = 'expr'

  -- nvim-treesitter provides indent queries
  if vim.tbl_contains(require('nvim-treesitter').get_installed('queries'), 'c') then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  else
    vim.bo.cindent = true
  end
end
