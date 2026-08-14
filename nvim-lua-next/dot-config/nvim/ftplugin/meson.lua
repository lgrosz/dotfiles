require('nvim-treesitter').install('meson')

vim.lsp.enable('mesonlsp')

if vim.treesitter.language.add('meson') then
  vim.treesitter.start()

  -- use neovim treesitter folding
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.wo.foldmethod = 'expr'

  -- nvim-treesitter provides indent queries
  if vim.tbl_contains(require('nvim-treesitter').get_installed('queries'), 'meson') then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end
