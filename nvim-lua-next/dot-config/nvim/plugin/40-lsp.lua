-- Shared, filetype-agnostic LSP setup. Servers themselves are enabled
-- per-filetype in after/ftplugin/<ft>.lua; their config lives in
-- after/lsp/<name>.lua (after/, so it beats nvim-lspconfig -- :h lsp-config-merge).
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- native LSP completion. autotrigger only fires on the server's
    -- triggerCharacters ('.', '->', ...); adding 'o' to 'complete' also feeds
    -- 'omnifunc' -- and so the LSP -- into 'autocomplete', which otherwise
    -- only offers buffer and tag words. See :h ins-autocompletion, :h 'complete'.
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
    vim.opt_local.complete:append('o')

    -- keymaps (override built-in gd motion)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
      vim.tbl_extend('error', opts, { desc = 'Go to [D]eclaration' }))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
      vim.tbl_extend('error', opts, { desc = 'Go to [d]efinition' }))
  end,
})
