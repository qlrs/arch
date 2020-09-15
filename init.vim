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

syntax on
nnoremap <SPACE> <Nop>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
vnoremap <C-c> "+y
" map <C-v> "+P
map <C-n> :NERDTreeToggle<CR>
map <C-g> :Goyo<CR>
map <C-p> :w !python<CR>
inoremap <S-Tab> <Esc>
nnoremap S :%s//g<Left><Left>

set t_Co=256
hi Normal ctermbg=none

set mouse=a

let mapleader=" "

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

call plug#begin()
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary' 
Plug 'davidhalter/jedi-vim'
Plug 'joshdick/onedark.vim'
Plug 'ap/vim-css-color'
call plug#end()

" colo onedark
