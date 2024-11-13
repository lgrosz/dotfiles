return {
  "neovim/nvim-lspconfig",
  config = function()
    require("plugins.lspconfig.clangd")
    require("plugins.lspconfig.lua-language-server")
    require("plugins.lspconfig.cmake-language-server")
    require("plugins.lspconfig.dockerfile-language-server")
    require("plugins.lspconfig.mesonlsp")
    require("plugins.lspconfig.pyright")
  end,
  dependencies = {
    "folke/neodev.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
}
