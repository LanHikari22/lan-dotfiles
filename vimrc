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
Plug 'yggdroot/indentLine'
 
"" Navigation
Plug 'preservim/nerdtree' 													" see config below
Plug 'preservim/tagbar'															
Plug 'junegunn/fzf.vim'															" see config below

"" UI
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'wincent/terminus'

"" Intellisence & Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " see config below

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

"" Plug 'junegunn/fzf.vim'
nmap !f :Files<cr>
nmap !g :Rg<cr>
nmap !t :Tags<cr>


"" Plug 'neoclide/coc.nvim'
" if hidden is not set, TextEdit might fail.
set hidden
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000
set updatetime=300
" don't give |ins-completion-menu} messages
set shortmess+=c
" always show signcolumns
set signcolumn=yes
" Use tab for trigger completion with charaacters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()
" Use <cr> to confirmcompletion, <C-g>u means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Use '[c' and ']c' to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add status line support, for integration with other plugin, checkout `:hcoc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
function! CocMinimalStatus() abort
  return get(g:, 'coc_status', '')
endfunction
let g:airline_section_c = '%t %#LineNr#%{CocMinimalStatus()}'
"
" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

call plug#end()


" write permision-protected file
nmap ,ws	:w !sudo tee % > /dev/null

colo gruvbox
let g:gruvbox_contrast_dark="hard"
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

