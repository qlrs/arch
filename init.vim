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

syntax on
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

inoremap <S-Tab> <Esc>
set t_Co=256
hi Normal ctermbg=none

set mouse=a


set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


