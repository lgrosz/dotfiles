return {
  "neovim/nvim-lspconfig",
  config = function()
    require("plugins.lspconfig.clangd")
    require("plugins.lspconfig.lua-language-server")
    require("plugins.lspconfig.cmake-language-server")
    require("plugins.lspconfig.dockerfile-language-server")
    require("plugins.lspconfig.mesonlsp")
    require("plugins.lspconfig.pyright")
    require("plugins.lspconfig.ts_ls")
  end,
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
}
