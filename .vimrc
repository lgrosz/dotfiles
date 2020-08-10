" Install the vim-plug plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" PLUGINS
" Some stuff to take a look at
" https://github.com/junegunn/vim-plug/wiki/tips#loading-plugins-manually
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-plug'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jiangmiao/auto-pairs'
Plug 'yuezk/vim-js'
 
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --ts-completer --clangd-completer' }
" Always load at the end
Plug 'ryanoasis/vim-devicons'
call plug#end()

" for devicons
"set encoding=UTF-8
"
" faster git gutter updating (may have performance repurcussions)
set updatetime=100

" replace ctrl p default with ag
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching=0
endif

" YCM settings
let g:ycm_autoclose_preview_window_after_insertion=1

" KEY MAPPINGS
" leader remap , is better than \
let mapleader=","
" map <kj> to esc in insert mode
imap kj <Esc>
" more natural split navigation
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap sc :bd<CR>
" more natural tab navigation
nnoremap H :tabp<CR>
nnoremap L :tabn<CR>
nnoremap tc :bd<CR>
nnoremap to :tabonly<CR>
" move *visually* between vertical lines
nnoremap j gj
nnoremap k gk
" turn on and off cursor highlighting
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
" NERDTree keymaps
" toggle/open nerdtree cwd as root
nnoremap <Leader>nt :NERDTreeToggle<CR>
" open nerdtree with vcs root as root
nnoremap <Leader>nv :NERDTreeVCS<CR>
" open nerdtree with current file as root
nnoremap <Leader>nf :NERDTreeFind<CR>
" FZF keymaps
nnoremap <Leader>o :FZF<CR>
" Ycm keymaps
nnoremap gd :YcmCompleter GoToDefinition<CR>
nnoremap gr :YcmCompleter GoToReferences<CR>
nnoremap <Leader>f :YcmCompleter FixIt<CR>
" Dispatch commands
nnoremap <Leader>dm :Dispatch grip -b<CR>

" COLORS
" enable syntax processing
syntax enable
" 256 colors in vim (export TERM='xterm-256color')
set t_Co=256
" my own colorscheme because I swear I cannot get anything to work the way I
" want it to
highlight SignColumn cterm=NONE ctermfg=NONE ctermbg=NONE guifg=#0D191F guibg=NONE

" cursor line
hi CursorLine cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
" vimdiff
highlight DiffAdd cterm=BOLD ctermfg=NONE ctermbg=DarkGreen
highlight DiffDelete cterm=BOLD ctermfg=NONE ctermbg=DarkRed
highlight DiffChange cterm=BOLD ctermfg=NONE ctermbg=Brown
highlight DiffText cterm=BOLD ctermfg=NONE ctermbg=Magenta


" SPACING
" on pressing tab, insert 4 spaces
set expandtab
" display tabs as 4 spaces only
set tabstop=4
" number of spaces a tab is when editing
set softtabstop=4
" when indenting with '>', insert 4 spaces
set shiftwidth=4

" html, css, Javascript
autocmd FileType html setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType css setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType typescript setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType json setlocal tabstop=2 softtabstop=2 shiftwidth=2

" so I don't overwrite the given filetype...
autocmd BufRead,BufNewFile *.tsx,*.jsx setlocal tabstop=2 softtabstop=2 shiftwidth=2

"UI CONFIG
" set line numbers
set number relativenumber
" show keystrokes
set showcmd
" show ruler
set ruler
" highlight current line, off by default, thanks
set nocursorline
set nocursorcolumn
" tab autocomplete for command menu
set wildmenu
" only redraw when needed (not during macros) --> faster macros
set lazyredraw
" highlight maching [{()}]
set showmatch

" Airline Plugin Configuration
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

let g:airline#extentions#hunks#enabled=0
let g:airline#extentions#branch#enabled=1

" SEARCHING
" search as characters are entered
set incsearch
" highlights all matches
set hlsearch
" turn off highlights after search is over
nnoremap <leader><space> :nohlsearch<CR>


" FOLDING
" enable folding
set foldenable
" keep most folds open by default, fold anything nested 10 indents
set foldlevelstart=10
" 10 nested folds maximum, shouldn't need any more
set foldnestmax=10
" fold based on indent level
set foldmethod=indent


" SCROLLING
nnoremap <leader>s :set scrollbind!<CR>

" netrw 
set nocp
syntax on
filetype off
filetype plugin indent on
