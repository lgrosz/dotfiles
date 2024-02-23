return {
  "neovim/nvim-lspconfig",
  config = function()
    require("plugins.lspconfig.clangd")
    require("plugins.lspconfig.lua-language-server")
    require("plugins.lspconfig.cmake-language-server")
  end,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
}
