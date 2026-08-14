-- filename, modified/readonly flags, then right-aligned filetype + line:col
vim.o.statusline = '%f %m%r%=%y %l:%c'

-- built-in dark colorscheme (swap to taste; see :h builtin-colorschemes)
vim.o.background = 'dark'
vim.cmd.colorscheme('habamax')
