call plug#begin()
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary' 
Plug 'ap/vim-css-color'
Plug 'kovetskiy/sxhkd-vim'

" lua
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/which-key.nvim'
Plug 'rafamadriz/friendly-snippets'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'

" colorschemes
Plug 'lunarvim/Onedarker.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'catppuccin/nvim', { 'as': 'catpuccin' }

" lsp stuff
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
call plug#end()

syntax on
" set number relativenumber
set clipboard=unnamed
set linebreak
set scrolloff=4
set encoding=utf-8
set wildmenu
set nohlsearch
set splitbelow splitright
set mouse=a
set tabstop=2
set incsearch
set shiftwidth=2
set softtabstop=2
set expandtab
" set colorcolumn=80
set autochdir
set completeopt = "menu,menuone,noselect"
highlight Pmenu ctermbg=blue guibg=blue
hi clear SpellBad
hi SpellBad ctermfg=009 guifg=#ffff00 " set laststatus=2
" set statusline=%t
" set statusline+=\ %h
" set statusline+=%m
" set statusline+=%r
" set statusline+=%y
" set statusline+=%=
" set statusline+=%c\
" set statusline+=%l\
" set statusline+=%L
" set statusline+=\ %{strftime(\"%I:%M\")}
" for lsp stuff
set signcolumn=no

" autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.sh
" autocmd BufNewFile *.c 0r ~/.config/nvim/templates/skeleton.c
" autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex
" autocmd BufNewFile *.pl 0r ~/.config/nvim/templates/skeleton.pl
" autocmd BufNewFile *.go 0r ~/.config/nvim/templates/skeleton.go
" autocmd BufNewFile *.html 0r ~/.config/nvim/templates/skeleton.html
" Stop autocomment on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" let mapleader=" "
" TODO do i need this vvvvvvvvvvvvvvv
" nnoremap <SPACE> <Nop>
" map Q <Nop>
" Move in insert mode
" inoremap <C-k> <Up>
" inoremap <C-j> <Down>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>
" inoremap <C-H> <C-W>
" map <C-h> <C-w>h
" map <C-j> <C-w>j
" map <C-k> <C-w>k
" map <C-l> <C-w>l

" map <leader>w :w<CR>
" map <leader>f :Telescope find_files<CR>
" map <leader>e :NvimTreeToggle<CR>
" map <leader>g :Goyo<CR>

" map <leader>c :setlocal spell! spelllang=en_us<CR>
" inoremap <S-Tab> <Esc>
" nnoremap S :%s//g<Left><Left>
" nnoremap <leader>v :vsp
" nnoremap <leader>t :tabnew<CR>
" nnoremap <leader>1 1gt
" nnoremap <leader>2 2gt
" nnoremap <leader>3 3gt
" nnoremap <leader>0 :tablast<CR>

let maplocalleader = ","
autocmd FileType c nnoremap <localleader>c :w<Esc>:!gcc %<CR>
autocmd FileType go nnoremap <localleader>f :!go fmt %<CR><CR>
autocmd FileType go nnoremap <localleader>e oif err != nil {<CR>log.Fatalf(err.Error())<CR>}<Esc>
autocmd FileType python nnoremap <localleader>f :!black -l 79 %<CR><CR>

lua <<EOF
-- Colorscheme
-- vim.cmd("colorscheme tokyonight-moon")
vim.cmd("colorscheme catppuccin-mocha")

-- Sets
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"

------------------------ Keybinds --------------------
vim.g.mapleader = " "
-- vim.api.nvim_del_keymap('', 'Q')

-- Simple shortcuts
vim.keymap.set('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', "<leader>dp", '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<leader>w', ':w<cr>')
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', ':Telescope git_files<cr>')
vim.keymap.set('n', '<leader>fs', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<cr>')
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>g', ':Goyo<cr>')

-- Move between windows
vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap= true})
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap= true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap= true})
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap= true})

-- Movement in insert mode
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')

-- Control + Backspace deletes word in insert mode
vim.keymap.set('i', '<C-H>', '<C-W>')

-- Open file in browser
vim.keymap.set('n', '<leader>o', ':!setsid firefox %<cr><cr>')

-- Skeletons
vim.api.nvim_command('autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.sh')
vim.api.nvim_command('autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex')
vim.api.nvim_command('autocmd BufNewFile *.pl 0r ~/.config/nvim/templates/skeleton.pl')
vim.api.nvim_command('autocmd BufNewFile *.go 0r ~/.config/nvim/templates/skeleton.go')
vim.api.nvim_command('autocmd BufNewFile *.html 0r ~/.config/nvim/templates/skeleton.html')

-- Markdown line wrapping
vim.api.nvim_command('autocmd FileType markdown setlocal tw=79')

-- Spellcheck
vim.keymap.set('n', '<leader>c', ':setlocal spell! spelllang=en_us<cr>')

-- Find and replace
vim.keymap.set('n', 'S', ':%s//g<Left><Left>')

-- New vertical split
vim.keymap.set('n', '<leader>v', ':vsp')

-- New tab
vim.keymap.set('n', '<leader>t', ':tabnew | Telescope find_files<cr>')
vim.keymap.set('v', '<leader>t', ':tabnew<cr>')

-- Switching between tabs in normal and visual mode
vim.keymap.set('n', '<leader>1', '1gt')
vim.keymap.set('n', '<leader>2', '2gt')
vim.keymap.set('n', '<leader>3', '3gt')
vim.keymap.set('v', '<leader>1', '1gt')
vim.keymap.set('v', '<leader>2', '2gt')
vim.keymap.set('v', '<leader>3', '3gt')

-- Make a split "fullscreen" (but not really just open in new tab)
vim.keymap.set('n', '<leader>m', ':tabe %<cr>')
------------------------End Keybinds--------------------------------------

---------------------------Start Plugins---------------------------------

-- go.nvim
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        require("go.format").goimport()
    end,
    group = format_sync_grp,
    })
require("go").setup()

-- which-key
local wk = require("which-key")
wk.register(mappings, opts)

-------------------------------------------------------------------------
-- friendly-snippets
-- see https://github.com/rafamadriz/friendly-snippets/tree/main/snippets
require("luasnip.loaders.from_vscode").lazy_load()
require'luasnip'.filetype_extend("python", {"python"})
require'luasnip'.filetype_extend("go", {"go"})
require'luasnip'.filetype_extend("html", {"html"})
require'luasnip'.filetype_extend("css", {"css"})
require'luasnip'.filetype_extend("bash", {"bash"})


-------------------------------------------------------------------------
-- nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup()

-------------------------------------------------------------------------
-- treesitter
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        },
    }

-- require('lualine').setup()
require('lualine').setup{
    options = {
        -- theme = "onedarker"
        -- theme = "tokyonight"
        theme = "catppuccin"
    },
    sections = {
        -- remove Linux penguin
        lualine_x = {"encoding", "filetype"},
        }
}


-------------------------------------------------------------------------
-- treesitter-context
require'treesitter-context'.setup{
    enable = true,
    max_lines = 0,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 20,
    trim_scope = 'outer',
    mode = 'cursor',
    separator = nil,
    zindex = 20,
    on_attach = nil,
}

-------------------------------------------------------------------------
-- bufferline
require'bufferline'.setup{
    options = {
        mode = "tabs",
    },
}

-------------------------------------------------------------------------
-- cmp
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

-------------------------------------------------------------------------
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
hi ColorColumn ctermbg=black guibg=black
