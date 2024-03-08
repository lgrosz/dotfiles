local cmp = require("cmp")

local mapping = { }

-- My mapping preset
--
-- I am not sure if this is really a good idea. nvim-cmp does a great job of
-- keeping the vim-default binds in-tact for each case with its presets... See
-- [mapping.lua](https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/mapping.lua)
mapping.preset = {
  -- Next match
  ["<C-n>"] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
    else
      cmp.complete()
    end
  end, { "i", "c", "s" }),
  -- Previous match
  ["<C-p>"] = cmp.mapping(function()
    if cmp.visible() then
      cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
    else
      cmp.complete()
    end
  end, { "i", "c", "s" }),
  -- Accept match
  ["<C-y>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.confirm({ select = true })
    else
      fallback()
    end
  end, { "i", "c", "s" }),
  -- End completion
  ["<C-e>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.abort()
    else
      fallback()
    end
  end, { "i", "c", "s" }),
}

return mapping
