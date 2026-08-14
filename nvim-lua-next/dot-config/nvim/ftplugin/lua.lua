require('nvim-treesitter').install('lua')

vim.lsp.enable('lua_ls')

if vim.treesitter.language.add('lua') then
  vim.treesitter.start()

  -- use neovim treesitter folding
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.wo.foldmethod = 'expr'

  -- nvim-treesitter provides indent queries
  if vim.tbl_contains(require('nvim-treesitter').get_installed('queries'), 'lua') then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end
