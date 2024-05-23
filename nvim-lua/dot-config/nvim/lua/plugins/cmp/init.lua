return {
  "hrsh7th/nvim-cmp",
  config = function()
    local cmp = require("cmp")

    cmp.setup {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = require("plugins.cmp.mapping").preset,
      sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
      },
      experimental = {
        ghost_text = true,
      },
    }

    require("plugins.cmp.cmdline").setup()
  end,

  dependencies = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
  },
}
