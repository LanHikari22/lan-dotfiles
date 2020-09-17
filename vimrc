" Created by Mohammed Alzakariya <github.com/LanHikari22>
" personal vim configuration to upload to new machines

call plug#begin()
" Download vim.plug to ~/.vim/autoload from github.com/junegunn/vim-plug
" run :PlugInstall to install plugins. 
"" Themes
Plug 'morhetz/gruvbox'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'altercation/vim-colors-solarized'

"" Editing
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'											" see config below
 
"" Navigation
Plug 'preservim/nerdtree' 													" see config below
Plug 'preservim/tagbar'															
Plug 'junegunn/fzf.vim'															" see config below

"" UI
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'

"" Intellisence & Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" plugin config
"" Plug 'preservim/nerdtree'
nmap !n :NERDTreeToggle<cr>
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
function s:CloseIfOnlyNerdTreeLeft()
	if exists("t:NERDTreeBufName")
		if bufwinnr(t:NERDTreeBufName) != -1
			if winnr("$") == 1
				q
			endif
		endif
	endif
endfunction

"" Plug 'preservim/nerdcommenter'
nmap <C-_>	<Plug>NERDCommenterToggle
vmap <C-_>	<Plug>NERDCommenterToggle<CR>gv
let g:NERDSpaceDelims = 1

""Plug 'junegunn/fzf.vim'
nmap !f :Files<cr>
nmap !g :Rg<cr>
nmap !t :Tags<cr>

call plug#end()


" write permision-protected file
nmap ,ws	:w !sudo tee % > /dev/null

colo gruvbox
set background=dark
set t_Co=256

set nu rnu
set hlsearch

filetype plugin on
syntax on

set clipboard=unnamedplus

set foldmethod=indent
set nofoldenable

set tabstop=2
set shiftwidth=0

set expandtab
set autoindent

