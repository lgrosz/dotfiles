-- Shared filetype setup. Both halves live under after/ so they survive the
-- runtime files, which load later and would otherwise clobber them. See :h
-- ftplugin-overrule.
--
-- The split matters: filetype dispatch runs every ftplugin/** file (after/
-- included) and only then every indent/** file, so an 'indentexpr' set from
-- after/ftplugin is still overwritten by indent/<ft>.vim. Highlighting and
-- folds go in after/ftplugin/<ft>.lua; indentation goes in
-- after/indent/<ft>.lua.
local M = {}

-- Default to the filetype so ftplugins shared between filetypes pick the right
-- parser: runtime ftplugin/cpp.vim sources ftplugin/c.lua, and a C++ buffer
-- needs the cpp parser, not c.
local function parser_for(parser)
  return parser or vim.bo.filetype
end

--- Enable the language server, and treesitter highlighting and folding, for
--- the current buffer. Call from after/ftplugin/<ft>.lua.
---
--- @param opts? table
---   - parser  (string)  treesitter parser name, when it differs from the
---                       filetype (e.g. 'qmljs' for qml).
---   - server  (string)  after/lsp/<name>.lua config to enable.
function M.setup(opts)
  opts = opts or {}
  local parser = parser_for(opts.parser)

  if opts.server then vim.lsp.enable(opts.server) end

  require('nvim-treesitter').install(parser)
  if not vim.treesitter.language.add(parser, { filetype = vim.bo.filetype }) then return end

  vim.treesitter.start()

  -- use neovim treesitter folding. vim.wo[0][0] is :setlocal -- a plain
  -- vim.wo would leak the fold settings into every later buffer opened in
  -- this window. See :h vim.wo.
  vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  vim.wo[0][0].foldmethod = 'expr'

  local undo = 'setl foldexpr< foldmethod<'
  vim.b.undo_ftplugin = vim.b.undo_ftplugin and (vim.b.undo_ftplugin .. ' | ' .. undo) or undo
end

--- Use nvim-treesitter's indent queries for the current buffer, when it ships
--- them for this parser. Call from after/indent/<ft>.lua.
---
--- @param parser? string treesitter parser name, when it differs from the filetype.
function M.indent(parser)
  parser = parser_for(parser)
  if not vim.tbl_contains(require('nvim-treesitter').get_installed('queries'), parser) then
    return
  end

  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

  local undo = 'setl indentexpr<'
  vim.b.undo_indent = vim.b.undo_indent and (vim.b.undo_indent .. ' | ' .. undo) or undo
end

return M
