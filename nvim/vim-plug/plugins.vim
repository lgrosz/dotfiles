" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

  " Better Syntax Support
  Plug 'sheerun/vim-polyglot'
  " File Explorer
  Plug 'francoiscabrol/ranger.vim'
  Plug 'rbgrouleff/bclose.vim'
  " Auto pairs for '(' '[' '{'
  Plug 'jiangmiao/auto-pairs'
  " CoC
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " More language support
  Plug 'HerringtonDarkholme/yats.vim'
  " Tags
  Plug 'ludovicchabant/vim-gutentags'
  " Markdown
  Plug 'plasticboy/vim-markdown'
  Plug 'junegunn/vim-easy-align'
  " FZF and worflow
  Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter'
  Plug 'tpope/vim-abolish'
  " Airline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Source control
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  " Airline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " One dark theme
  Plug 'joshdick/onedark.vim'
  " Dev Icons - must be loaded last
  Plug 'ryanoasis/vim-devicons'

call plug#end()
