return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({ })

    -- keymaps
    map("n", "ff", "<Cmd>Fzf files<Cr>", { silent = true, desc = "Find files" })
    map("n", "fg", "<Cmd>Fzf grep<Cr>", { silent = true, desc = "Grep in files" })
    map("n", "fgg", "<Cmd>Fzf grep<Cr><Cr>", { silent = true, desc = "Grep if files, without prompt" })
  end,
}

