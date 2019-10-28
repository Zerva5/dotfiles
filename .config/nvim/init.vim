set number
:let mapleader = " "
set nocompatible
filetype plugin on
syntax on

function SetWikiOptions()
	setlocal spell
	setlocal textwidth=80
	endfunction



:nnoremap <Leader>d "=strftime("%d-%m-%y")<CR>p
:nnoremap <Leader>dd "=strftime("%a, %d %b %Y")<CR>p

autocmd BufRead,BufNewFile *.wiki call SetWikiOptions()

call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vimwiki/vimwiki'
call plug#end()


autocmd vimenter * NERDTree
