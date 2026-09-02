-- Keymaps that are not tied to a plugin. Plugin mappings live next to that
-- plugin's config, in plugin/30-plugins/<plugin>.lua.

-- Escape insert mode
vim.keymap.set('i', 'fd', '<Esc>', { desc = 'Escape insert mode' })

-- Diagnostic keymaps
-- See :diagnostic-defaults
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
