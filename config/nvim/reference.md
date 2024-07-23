# stuff i probably don't need anymore
Plug 'ryanoasis/vim-devicons'
Plug 'ray-x/guihua.lua'
"highlight Pmenu ctermbg=blue guibg=blue
set completeopt = "menu,menuone,noselect"





# options i still need to figure out
hi clear SpellBad
hi SpellBad ctermfg=009 guifg=#ffff00 " set laststatus=2
"set signcolumn=no

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd FileType go nnoremap <localleader>e oif err != nil {<CR>log.Fatalf(err.Error())<CR>}<Esc>
autocmd FileType python nnoremap <localleader>f :!black -l 79 %<CR><CR>





# maybe i will need this for programming
-- cmp
  ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
})
