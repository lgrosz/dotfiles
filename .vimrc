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
Plug 'junegunn/fzf', { 'do': {-> fzf#install()} }
Plug 'preservim/nerdtree'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --ts-completer --clangd-completer' }
" Always load at the end
Plug 'ryanoasis/vim-devicons'
call plug#end()

" for devicons
set encoding=UTF-8

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
nnoremap <Leader>nc :NERDTree %<CR>
" FZF keymaps
nnoremap <Leader>o :FZF<CR>

" COLORS
" enable syntax processing
syntax enable
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

"UI CONFIG
" set line numbers
set number
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

