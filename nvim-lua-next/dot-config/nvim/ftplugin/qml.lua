-- treesitter parser is 'qmljs'; register it for the 'qml' filetype
require('nvim-treesitter').install('qmljs')

vim.lsp.enable('qmlls')

if vim.treesitter.language.add('qmljs', { filetype = 'qml' }) then
  vim.treesitter.start()

  -- use neovim treesitter folding
  vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.wo.foldmethod = 'expr'

  -- nvim-treesitter provides indent queries
  if vim.tbl_contains(require('nvim-treesitter').get_installed('queries'), 'qmljs') then
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end
