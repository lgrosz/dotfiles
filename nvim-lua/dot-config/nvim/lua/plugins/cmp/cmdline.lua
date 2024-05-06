return {
  setup = function()
    local cmp = require("cmp")

    -- Ex commands
    cmp.setup.cmdline(":", {
      mapping = require("plugins.cmp.mapping").preset,
      -- For some reason, I cannot use the path source here?? Completion just stops working.
      sources = {
        {
          name = "cmdline",
          option = {
            ignore_cmds = { "Man", "!" }
          }
        },
        {
          name = "cmdline_history"
        },
      },
      experimental = {
        ghost_text = true,
      },
    })

    -- Search
    cmp.setup.cmdline("/", {
      mapping = require("plugins.cmp.mapping").preset,
      sources = {
        { name = "buffer" }
      },
      experimental = {
        ghost_text = true,
      },
    })

  end
}
