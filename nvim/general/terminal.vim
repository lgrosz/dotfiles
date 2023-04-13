" Specific settings for terminal-mode
autocmd TermOpen * setlocal nonumber norelativenumber " Don't show line numbers when opening a terminal session
autocmd TermOpen * startinsert                        " Enter insert-mode when opening a terminal session
autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>

