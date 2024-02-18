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
      mapping = {
        -- Next match
        ['<C-n>'] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.complete()
          end
        end),
        -- Previous match
        ['<C-p>'] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
          else
            cmp.complete()
          end
        end),
        -- Accept match
        ['<C-y>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          else
            fallback()
          end
        end),
        -- End completion
        ['<C-e>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.abort()
          else
            fallback()
          end
        end),
      },
      sources = {
        { name = "buffer" }
      },
      experimental = {
        ghost_text = true,
      },
    }
  end,
  dependencies = {
    'hrsh7th/cmp-buffer',
  },
}
