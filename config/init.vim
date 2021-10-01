call plug#begin()
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary' 
Plug 'ap/vim-css-color'
call plug#end()

set number
set laststatus=2
set statusline=%t
set statusline+=\ %h
set statusline+=%m
set statusline+=%r
set statusline+=%y
set statusline+=%=
set statusline+=%c\
set statusline+=%l\
set statusline+=%L
set statusline+=\ %{strftime(\"%I:%M\")}
set clipboard=unnamed
set linebreak
set scrolloff=4
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set nocompatible
set encoding=utf-8
syntax on
let mapleader=" "
set wildmenu
set nohlsearch
set splitbelow splitright

nnoremap <SPACE> <Nop>
map Q <Nop>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <leader>n :NERDTreeToggle<CR>
map <leader>g :Goyo<CR>
map <C-p> :w !perl<CR>
inoremap <S-Tab> <Esc>
nnoremap S :%s//g<Left><Left>
nnoremap <leader>w :vsp

set t_Co=256
hi Normal ctermbg=none

set mouse=a


set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

" colo onedark
