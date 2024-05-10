call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary' 
Plug 'folke/zen-mode.nvim'
Plug 'ap/vim-css-color'
Plug 'kovetskiy/sxhkd-vim'

" lua
Plug 'nvim-lualine/lualine.nvim'
Plug 'folke/which-key.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'
Plug 'rrethy/vim-illuminate'
Plug 'rafamadriz/friendly-snippets'

" colorschemes
Plug 'lunarvim/Onedarker.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'catppuccin/nvim', { 'as': 'catpuccin' }
Plug 'ellisonleao/gruvbox.nvim'
Plug 'dracula/vim'

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

set completeopt = "menu,menuone,noselect"
"highlight Pmenu ctermbg=blue guibg=blue
hi clear SpellBad
hi SpellBad ctermfg=009 guifg=#ffff00 " set laststatus=2
"set signcolumn=no
"let maplocalleader = ","

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

autocmd FileType go nnoremap <localleader>e oif err != nil {<CR>log.Fatalf(err.Error())<CR>}<Esc>
autocmd FileType python nnoremap <localleader>f :!black -l 79 %<CR><CR>

lua <<EOF
vim.g.maplocalleader = ","
-- Colorscheme
-- vim.cmd("colorscheme onedarker")
vim.cmd("colorscheme catppuccin-mocha")
-- vim.cmd("colorscheme dracula")
-- vim.cmd("colorscheme gruvbox")

-- vim.o.background = "dark"

-- Sets
vim.cmd("syntax on")
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
-- TEST----------------------------------------------------------------------
vim.opt.clipboard = "unnamedplus"
vim.opt.linebreak = true
vim.opt.scrolloff = 4
vim.opt.wildmenu = true
vim.opt.hlsearch = false
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.incsearch = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autochdir = true
vim.opt.signcolumn = "yes"
-- TEST END -----------------------------------------------------------------

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
vim.keymap.set('n', '<leader>g', ':ZenMode<cr>')

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
-- vim.keymap.set('i', '<C-H>', '<C-W>')
-- vim.api.nvim_set_keymap('i', '<C-H>', '<C-W>', {noremap = true})

-- Open file in browser
vim.keymap.set('n', '<leader>o', ':!setsid firefox %<cr><cr>')

-- Skeletons
vim.api.nvim_command('autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.sh')
vim.api.nvim_command('autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex')
vim.api.nvim_command('autocmd BufNewFile *.pl 0r ~/.config/nvim/templates/skeleton.pl')
vim.api.nvim_command('autocmd BufNewFile *.go 0r ~/.config/nvim/templates/skeleton.go')
vim.api.nvim_command('autocmd BufNewFile *.html 0r ~/.config/nvim/templates/skeleton.html')

-- Markdown stuff
vim.api.nvim_command('autocmd FileType markdown setlocal tw=79')
vim.api.nvim_command('autocmd FileType markdown setlocal conceallevel=1')

-- Spellcheck
vim.keymap.set('n', '<leader>s', ':setlocal spell! spelllang=en_us<cr>')

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
-- friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-------------------------------------------------------------------------

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
        additional_vim_regex_highlighting = true,
        },
    }

-- require('lualine').setup()
require('lualine').setup{
    options = {
        -- theme = "onedarker"
        -- theme = "tokyonight"
        theme = "catppuccin"
        -- theme = "gruvbox"
        -- theme = "dracula"
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
--- Experimental stuff
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>z', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})
---------------------

EOF
hi ColorColumn ctermbg=black guibg=black
