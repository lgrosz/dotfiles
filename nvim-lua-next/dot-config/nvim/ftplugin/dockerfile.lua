require('nvim-treesitter').install('dockerfile')

vim.lsp.enable('dockerls')

if vim.treesitter.language.add('dockerfile') then
  vim.treesitter.start()

  -- use neovim treesitter folding
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.wo.foldmethod = 'expr'

  -- nvim-treesitter provides indent queries
  if vim.tbl_contains(require('nvim-treesitter').get_installed('queries'), 'dockerfile') then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end
