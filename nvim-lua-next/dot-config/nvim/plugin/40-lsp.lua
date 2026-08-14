-- Shared, filetype-agnostic LSP setup. Servers themselves are enabled
-- per-filetype in ftplugin/<ft>.lua; their config lives in lsp/<name>.lua.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- native LSP completion
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })

    -- keymaps (override built-in gd motion)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  end,
})
