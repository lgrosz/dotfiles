return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function ()
    local cc = require("codecompanion")

    cc.setup({
      strategies = {
        chat = {
          adapter = "deepseek",
        },
      },
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "deepseek",
            schema = {
              model = {
                default = "deepseek-r1:7b",
              },
            },
          })
        end,
      },
      prompt_library = {
        ["Code Expert"] = {
          strategy = "chat",
          description = "Get some special advice from an LLM",
          opts = {
            mapping = "<Leader>ce",
            modes = { "v" },
            short_name = "expert",
            auto_submit = true,
            stop_context_insertion = true,
            user_prompt = true,
          },
          prompts = {
            {
              role = "system",
              content = function(context)
                return "I want you to act as a senior "
                .. context.filetype
                .. " developer. I will ask you specific questions and I want you to return concise explanations and codeblock examples."
              end,
            },
            {
              role = "user",
              content = function(context)
                local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

                return "I have the following code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
              end,
              opts = {
                contains_code = true,
              }
            },
          },
        },
      },
    })

    -- keymaps
    vim.keymap.set({ "n", "v" }, "<leader>cc", cc.chat, { desc = "[C]odecompanion [C]hat"})
  end
}

