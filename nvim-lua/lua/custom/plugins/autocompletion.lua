return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    -- Buffer
    'hrsh7th/cmp-buffer',
    'amarakon/nvim-cmp-buffer-lines',

    -- Command line
    'hrsh7th/cmp-cmdline',
    'dmitmel/cmp-cmdline-history',

    -- LSP
    'hrsh7th/cmp-nvim-lsp',

    -- Snippets
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',

    -- Misc
    'quangnguyen30192/cmp-nvim-tags',
    'petertriho/cmp-git',
  },
  config = function ()
    local cmp = require('cmp')
    cmp.setup {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'tags' },
      },
    }

    -- Git commit completion
    cmp.setup.filetype('gitcommit', {
      sources = {
        { name = 'git' },
        { name = 'buffer' },
      }
    })

    -- C/C++ completion
    cmp.setup.filetype({ "c", "cpp" }, {
      sources = {
        { name = 'nvim_lsp' },
        { name = 'tags' },
        { name = "buffer-lines" },
        { name = 'buffer' },
      }
    })

    -- Search completion
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
        { name = 'cmdline_history' },
      }
    })

    -- Command completion
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'path' },
        { name = 'cmdline' },
        { name = 'cmdline_history' },
      }
    })
  end
}
