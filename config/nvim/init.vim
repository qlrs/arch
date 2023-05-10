call plug#begin()
Plug 'tpope/vim-surround'
Plug 'preservim/nerdtree'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary' 
Plug 'ap/vim-css-color'
Plug 'lervag/vimtex'
Plug 'kovetskiy/sxhkd-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
call plug#end()

lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        },
    }
EOF

lua <<EOF
  local cmp = require'cmp'

  cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['bashls'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }

EOF


syntax on
set number relativenumber
set clipboard=unnamed
set linebreak
set scrolloff=6
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
set colorcolumn=80
set autochdir
set completeopt = "menu,menuone,noselect"
highlight ColorColumn ctermbg=8
highlight Pmenu ctermbg=blue guibg=blue
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
" for lsp stuff
set signcolumn=no

autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.sh
autocmd BufNewFile *.c 0r ~/.config/nvim/templates/skeleton.c
autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex
autocmd BufNewFile *.pl 0r ~/.config/nvim/templates/skeleton.pl
autocmd BufNewFile *.go 0r ~/.config/nvim/templates/skeleton.go
autocmd BufNewFile *.html 0r ~/.config/nvim/templates/skeleton.html
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

let mapleader=" "
nnoremap <SPACE> <Nop>
map Q <Nop>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-H> <C-W>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

map <leader>f :Telescope find_files<CR>
map <leader>e :NERDTreeToggle<CR>
map <leader>g :Goyo<CR>
map <leader>w :w<CR>
map <leader>c :setlocal spell! spelllang=en_us<CR>
inoremap <S-Tab> <Esc>
nnoremap S :%s//g<Left><Left>
nnoremap <leader>v :vsp
nnoremap <leader>F :vert winc f<CR>

" For vimtex
filetype plugin indent on
let g:vimtex_view_method = 'zathura'
let maplocalleader = ","

autocmd FileType tex nnoremap <localleader>ul i\begin{itemize}<CR>\item<CR>\end{itemize}<Esc>Bd0kA<Space>
autocmd FileType html nnoremap <localleader>p i<p></p><Esc>hhhi
autocmd FileType html nnoremap <localleader>h1 i<h1></h1><Esc>hhhhi
autocmd FileType html nnoremap <localleader>ah i<a href=""></a><Esc>F"i
autocmd FileType html nnoremap <localleader>aht i<a href="" target="_blank"></a><Esc>3F"i
autocmd FileType html nnoremap <localleader>f f>a
autocmd FileType c nnoremap <localleader>c :w<Esc>:!gcc %<CR>
autocmd FileType c nnoremap <localleader>mv iint<CR>main(void)<CR>{<CR>}<Esc>ko
autocmd FileType c nnoremap <localleader>ma iint<CR>main(int argc, char **argv)<CR>{<CR>}<Esc>ko
autocmd FileType c nnoremap <localleader>f ofor (int i = 0; i < x; i++)<Esc><S-f>xs
autocmd FileType go nnoremap <localleader>f :!go fmt %<CR><CR>
autocmd FileType go nnoremap <localleader>e oif err != nil {<CR>log.Fatal(err)<CR>}<Esc>
autocmd FileType python nnoremap <localleader>f :!black -l 79 %<CR><CR>

