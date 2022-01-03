call plug#begin()
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary' 
Plug 'ap/vim-css-color'
Plug 'lervag/vimtex'
Plug 'kovetskiy/sxhkd-vim'
call plug#end()

syntax on
set number relativenumber
set clipboard=unnamed
set linebreak
set scrolloff=3
set nocompatible
set encoding=utf-8
set wildmenu
set nohlsearch
set splitbelow splitright
set mouse=a
set tabstop=4
set incsearch
set shiftwidth=4
set softtabstop=4
set expandtab
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

autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.sh
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
let mapleader=" "

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
map <leader>w :w<CR>
map <leader>c :setlocal spell! spelllang=en_us<CR>
map <leader><leader>f :filetype detect<CR>
inoremap <S-Tab> <Esc>
nnoremap S :%s//g<Left><Left>
nnoremap <leader>W :vsp
nnoremap <leader>f :vert winc f<CR>
nnoremap <leader>s :!clear && shellcheck %<CR>

" For vimtex
filetype plugin indent on
let g:vimtex_view_method = 'zathura'
let maplocalleader = ","

autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex
autocmd FileType tex nnoremap <localleader>ul i\begin{itemize}<CR>\item<CR>\end{itemize}<Esc>Bd0kA<Space>
autocmd FileType html nnoremap <localleader>p i<p></p><Esc>hhhi
autocmd FileType html nnoremap <localleader>h1 i<h1></h1><Esc>hhhhi
autocmd FileType html nnoremap <localleader>ah i<a href=""></a><Esc>F"i
