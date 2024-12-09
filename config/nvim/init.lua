vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- sets
vim.cmd("syntax on")
vim.opt.relativenumber = true
vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamedplus"
--vim.opt.linebreak = true
vim.opt.scrolloff = 4
vim.opt.wildmenu = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 2
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autochdir = true
vim.opt.signcolumn = "yes"
-- to prevent auto-comments
vim.opt_local.formatoptions:remove({ 'r', 'o' })
-- needed for bufferline.nvim
vim.opt.termguicolors = true

-- keybinds
-- simple shortcuts
-- vim.keymap.set('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
-- vim.keymap.set('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.keymap.set('n', '<leader>.', ':Oil<cr>')
vim.keymap.set('n', '<leader>w', ':w<cr>')
vim.keymap.set('n', '<leader>g', ':ZenMode<cr>')
-- move between windows
vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap= true})
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap= true})
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap= true})
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap= true})
-- movement in insert mode
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')
-- control + backspace deletes word in insert mode
vim.api.nvim_set_keymap('i', '<C-BS>', '<C-w>', {noremap = true})
-- open file in browser
vim.keymap.set('n', '<leader>o', ':!setsid firefox %<cr><cr>')
-- skeletons
vim.api.nvim_command('autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.sh')
vim.api.nvim_command('autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex')
-- markdown stuff
vim.api.nvim_command('autocmd FileType markdown setlocal tw=79')
vim.api.nvim_command('autocmd FileType markdown setlocal conceallevel=1')
-- spellcheck
vim.keymap.set('n', '<leader>s', ':setlocal spell! spelllang=en_us<cr>')
-- find and replace
vim.keymap.set('n', 'S', ':%s//g<Left><Left>')
-- new vertical split
vim.keymap.set('n', '<leader>v', ':vsp')
-- new tab
vim.keymap.set('n', '<leader>t', ':tabnew | Telescope find_files<cr>')
vim.keymap.set('v', '<leader>t', ':tabnew<cr>')
-- switching between tabs in normal and visual mode
vim.keymap.set('n', '<leader>1', '1gt')
vim.keymap.set('n', '<leader>2', '2gt')
vim.keymap.set('n', '<leader>3', '3gt')
vim.keymap.set('v', '<leader>1', '1gt')
vim.keymap.set('v', '<leader>2', '2gt')
vim.keymap.set('v', '<leader>3', '3gt')
-- make a split "fullscreen" (but not really just open in new tab)
vim.keymap.set('n', '<leader>m', ':tabe %<cr>')
-- telescope
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>')
vim.keymap.set('n', '<leader>fg', ':Telescope git_files<CR>')
vim.keymap.set('n', '<leader>fs', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>')
-- nvim-tree
vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>')
-- python format
vim.api.nvim_set_keymap('n', '<localleader>f', ':!black -l 79 %<CR><CR>', {noremap = true, silent = true})




-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
})

require("colorizer").setup()
