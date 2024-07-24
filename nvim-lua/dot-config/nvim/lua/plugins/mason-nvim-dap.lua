-- Integrates mason and nvim-dap

return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    automatic_installation = true, -- Install servers configured with nvim-dap
  },
  dependencies = {
    "williamboman/mason.nvim",
  },
}
