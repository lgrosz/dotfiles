-- Integrates mason and lspconfig

return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    automatic_installation = true, -- Install servers configured with lspconfig
  },
  dependencies = {
    "williamboman/mason.nvim",
  },
}
