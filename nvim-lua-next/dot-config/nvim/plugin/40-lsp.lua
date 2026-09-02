-- Shared, filetype-agnostic LSP setup. Servers themselves are enabled
-- per-filetype in after/ftplugin/<ft>.lua; their config lives in
-- after/lsp/<name>.lua (after/, so it beats nvim-lspconfig -- :h lsp-config-merge).
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Let the LSP drive its own menu via autotrigger, and leave 'complete'
    -- alone. Adding "o" routes the LSP through 'omnifunc' as an 'autocomplete'
    -- source, but vim.lsp.omnifunc answers asynchronously: it returns -2 and
    -- calls vim.fn.complete() when the reply lands. That fights the
    -- 'autocomplete' collection cycle for ownership of the menu, and the list
    -- flickers away as you type. See :h ins-autocompletion, :h lsp-completion,
    -- and neovim/neovim#40060 on how the two paths do not yet harmonise.
    vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })

    -- keymaps (override built-in gd motion)
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
      vim.tbl_extend('error', opts, { desc = 'Go to [D]eclaration' }))
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
      vim.tbl_extend('error', opts, { desc = 'Go to [d]efinition' }))
  end,
})
