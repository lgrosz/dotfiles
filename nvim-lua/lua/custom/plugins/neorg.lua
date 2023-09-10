return {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  depedencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("neorg").setup {
      load = {
        ['core.defaults'] = { }, -- Loads default behavior
        ['core.concealer'] = { }, -- Pretty icons
        ['core.promo'] = { }, -- Item promotion
        ['core.dirman'] = { -- Loads default behavior
          config = {
            workspaces = {
              notes = "~/notes",
            },
            default_workspace = "notes",
          },
        },
      },
    }
  end,
}
