-- update nvim-treesitter parsers
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })

-- Download plugins. If needed, plugins are configured in
-- plugin/30-plugins.lua
vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/tpope/vim-abolish',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-surround',
})

