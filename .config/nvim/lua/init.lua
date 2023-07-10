--- For vim tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--- vim-plug
local Plug = vim.fn['plug#']
vim.cmd("call plug#begin()")
Plug 'vimwiki/vimwiki'

Plug 'nvim-tree/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'

Plug 'preservim/nerdcommenter'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

vim.cmd("Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.2.*', 'do': 'make install_jsregexp'} ")

vim.cmd("call plug#end()")

-- Setup cmp (completion)
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
require('cmp_setup')

-- Setup lsp's
require('lsp_config')

-- nerdcommenter settigns
vim.cmd('let g:NERDCreateDefaultMappings = 0')

--- Load keybinds
require('keybinds')


-- some misc vim options
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.cmd("colorscheme slate")

---------------- VIM WIKI
vim.opt.compatible = false
vim.cmd('filetype plugin on')
vim.cmd('syntax on')

-- vimwiki default wiki location
vim.g.vimwiki_list = { { path = "~/Documents/wiki", auto_diary_index = 1, syntax = 'markdown', ext = '.md' } }


------------------ NVIM TREE
require("nvim-tree").setup(
	{
		update_focused_file = { enable = true, }
	})


