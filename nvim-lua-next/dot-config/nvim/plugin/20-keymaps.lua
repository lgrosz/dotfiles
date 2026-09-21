-- Keymaps that are not tied to a plugin. Plugin mappings live next to that
-- plugin's config, in plugin/30-plugins/<plugin>.lua.

-- Escape insert mode
vim.keymap.set('i', 'fd', '<Esc>', { desc = 'Escape insert mode' })

-- Diagnostic keymaps
-- See :diagnostic-defaults
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Spelling suggestions through vim.ui.select (fzf-lua, see
-- plugin/30-plugins/fzf-lua.lua) instead of the built-in numbered list. A
-- count keeps the native behaviour of taking that suggestion directly.
-- TODO: recheck after every nvim upgrade; drop this if :h z= says it uses
-- vim.ui.select.
vim.keymap.set('n', 'z=', function()
  if vim.v.count > 0 then return vim.cmd.normal({ vim.v.count .. 'z=', bang = true }) end
  local word = vim.fn.expand('<cword>')
  local suggestions = vim.fn.spellsuggest(word)
  if #suggestions == 0 then return vim.notify(('No suggestions for "%s"'):format(word)) end
  vim.ui.select(suggestions, { prompt = ('Replace "%s"'):format(word) }, function(choice)
    if choice then vim.cmd.normal({ 'ciw' .. choice, bang = true }) end
  end)
end, { desc = 'Spelling suggestions' })
