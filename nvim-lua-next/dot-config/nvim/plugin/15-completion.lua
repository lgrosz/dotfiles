-- Built-in autocompletion. See :h ins-autocompletion.
-- The LSP drives its own menu on LspAttach, in plugin/40-lsp.lua; 'complete'
-- is left alone so the two do not fight over the popup.
vim.o.autocomplete = true

--   fuzzy     match and rank candidates loosely, rather than by prefix
--   noinsert  never put text in the buffer until <C-y> accepts it, but do
--             preselect the top match so a bare <C-y> takes it
--   popup     show the selected item's documentation, via completionItem/resolve
--
-- noinsert is load-bearing. :h 'completeopt' says noselect is implied when
-- 'autocomplete' is on, but that does not hold for the path the LSP takes:
-- vim.lsp.omnifunc replies asynchronously and calls vim.fn.complete(), which
-- honours 'completeopt' literally. Without it that call selects *and inserts*
-- the first candidate, overwriting what you typed on every keystroke.
vim.o.completeopt = 'fuzzy,noinsert,popup'
