return {
  "neovim/nvim-lspconfig",
  config = function()
    require("plugins.lspconfig.clangd")
    require("plugins.lspconfig.lua-language-server")
  end,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
}
