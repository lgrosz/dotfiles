return {
  'stevearc/oil.nvim',
  config = function ()
    local oil = require("oil")

    -- TODO Configure float to look like fzf-lua
    oil.setup({ })

    -- keymaps
    vim.keymap.set('n', '<leader>nf', oil.toggle_float, { desc = '[N]avigate [F]iles' })

    -- oil keymaps
    -- TODO Is this best done here, or in ftplugin?
    vim.api.nvim_create_autocmd(
      'FileType',
     {
        pattern = 'oil',
        callback = function()
          vim.keymap.set(
            'n',
            '<leader>t',
            function()
              local dir = require('oil').get_current_dir()

              -- Create a scratch buffer
              local buf = vim.api.nvim_create_buf(false, true)
              local ui = vim.api.nvim_list_uis()[1]

              -- Setup floating window
              local win_width = math.ceil(ui.width * 0.8)
              local win_height = math.ceil(ui.height * 0.8)

              vim.api.nvim_open_win(buf, true, {
                relative = 'editor',
                width = win_width,
                height = win_height,
                col = math.ceil((ui.width - win_width) / 2),
                row = math.ceil((ui.height - win_height) / 2),
              })

              -- Open terminal at current oil location
              -- TODO How do I cd???
              --vim.api.nvim_buf_call(
              --  buf,
              --  function()
              --    vim.fn.termopen('cd', { cwd = dir })
              --  end
              --)
            end,
            { desc = 'Open [T]erminal at current directory' }
          )
        end,
      }
    )
  end
}
