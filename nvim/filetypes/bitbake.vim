" Download bitbake syntax highlighting
if empty(glob('~/.config/nvim/syntax/bitbake.vim'))
  silent !curl -fLo ~/.config/nvim/syntax/bitbake.vim --create-dirs
    \ https://git.yoctoproject.org/poky/plain/bitbake/contrib/vim/syntax/bitbake.vim
endif

au BufRead,BufNewFile *.bb set filetype=bitbake
au BufRead,BufNewFile *.bbclass set filetype=bitbake
au BufRead,BufNewFile *.inc set filetype=bitbake
