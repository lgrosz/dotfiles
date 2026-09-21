-- Set before vim.pack.add: plugins loaded there define their mappings
-- immediately, and <Leader> is resolved when a mapping is defined, not
-- when it is used. See :h mapleader.
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- update nvim-treesitter parsers
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and kind == 'update' then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })

-- Keep terminal background synced to neovim background, via OSC 11.
--
-- tmux swallows OSC 11 outright -- inside a session the only one that reaches
-- the outer terminal is tmux's own `OSC 11 ?` query -- so under $TMUX the
-- sequence has to travel in tmux's DCS passthrough, with every ESC in the
-- payload doubled. That needs `set -g allow-passthrough on` in tmux.conf;
-- without it tmux drops the wrapper too.
local function osc(seq)
  if vim.env.TMUX then
    seq = '\027Ptmux;' .. seq:gsub('\027', '\027\027') .. '\027\\'
  end
  io.write(seq)
end

local function sync_term_bg()
  local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
  if not normal.bg then return end
  osc(string.format('\027]11;#%06x\027\\', normal.bg))
end

-- ColorScheme alone is not enough: the default colorscheme fires no such
-- event, so a config that never calls :colorscheme would never sync.
vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, { callback = sync_term_bg })

-- OSC 111 resets to the terminal's own configured background.
vim.api.nvim_create_autocmd('UILeave', {
  callback = function() osc('\027]111\027\\') end,
})

-- Download plugins. Each plugin is configured, with its mappings, in
-- plugin/30-plugins/<plugin>.lua
vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/tpope/vim-abolish',
  'https://github.com/tpope/vim-dadbod',
  'https://github.com/tpope/vim-dispatch',
  'https://github.com/tpope/vim-fugitive',
  'https://github.com/tpope/vim-surround',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
})

