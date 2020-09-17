" Created by Mohammed Alzakariya <github.com/LanHikari22>
" personal vim configuration to upload to new machines

call plug#begin()
" Download vim.plug to ~/.vim/autoload from github - junegunn/vim-plug
" run :PlugInstall to install plugins. 
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdtree' 													" see config below
Plug 'preservim/nerdcommenter'											" see config below
Plug 'preservim/tagbar'															
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf.vim'															" see config below
Plug 'vim-airline/vim-airline'
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
filetype plugin on
nmap <C-_>	<Plug>NERDCommenterToggle
vmap <C-_>	<Plug>NERDCommenterToggle<CR>gv
let g:NERDSpaceDelims = 1

""Plug 'junegunn/fzf.vim'
nmap !f :Files<cr>
nmap !g :Rg<cr>
nmap !t :Tags<cr>

call plug#end()

set nu rnu
set hlsearch
set tabstop=2
set shiftwidth=0
set autoindent

" write permision-protected file
nmap ,ws	:w !sudo tee % > /dev/null

colo gruvbox
