" Created by Mohammed Alzakariya <github.com/LanHikari22>
" personal vim configuration to upload to new machines

call plug#begin()
" Download vim.plug to ~/.vim/autoload from github.com/junegunn/vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" run :PlugInstall to install plugins. 

""""""""""""""""""""""""""""""
" plugin List
""""""""""""""""""""""""""""""

"" Themes
Plug 'morhetz/gruvbox'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'altercation/vim-colors-solarized'

"" Editing
Plug 'jiangmiao/auto-pairs'                         " see config below
Plug 'preservim/nerdcommenter'                      " see config below
Plug 'yggdroot/indentLine'
  " visualizes indent lines
Plug 'svermeulen/vim-macrobatics'                   " see config below 
  " enhanced macro operation
Plug 'tpope/vim-surround'                           " see config below
  " surround parentheses, brackets, quotes, XML tags, and more.
Plug 'justinmk/vim-sneak'                           " see config below
  " 's' to jump to any location specified by two characters
Plug 'chrisbra/Recover.vim'                         
  " Recover.vim adds a diff option when Vim finds a swap file
 
"" Navigation
Plug 'preservim/nerdtree'                           " see config below
Plug 'preservim/tagbar'                              
Plug 'liuchengxu/vista.vim'                         " see config below
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim'                              " see config below
Plug 'antoinemadec/coc-fzf'                         " see config below
Plug 'kshenoy/vim-signature'

"" UI
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'wincent/terminus'
Plug 'jacquesbh/vim-showmarks'


Plug 'tpope/vim-sensible'
Plug 'Tarmean/fzf-session.vim'
Plug 'tpope/vim-obsession'

"" Intellisence & Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " see config below

""""""""""""""""""""""""""""""
" plugin config
""""""""""""""""""""""""""""""

Plug 'jiangmiao/auto-pairs'
let g:AutoPairsShortcutFastWrap='<C-e>'   " turns (|)token into (token)|, can repeat consume

"" Plug 'preservim/nerdtree'
nmap !n :NERDTreeToggle<cr>
nmap #n :NERDTreeFind<cr>

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
nmap <C-_>  <Plug>NERDCommenterToggle
vmap <C-_>  <Plug>NERDCommenterToggle<CR>gv
let g:NERDSpaceDelims = 1

"" Plug 'justinmk/vim-sneak'
xmap <S-s> <Plug>Sneak_S
omap s <Plug>Sneak_s
omap S <Plug>Sneak_S

"" Plug 'tpope/vim-surround'
" move VSurround to z to make vim-sneak consistent in operator mode
xmap z <Plug>VSurround
let g:surround_no_mappings= 1
xmap z <Plug>VSurround
nmap yzz <Plug>Yssurround
nmap yz  <Plug>Ysurround
nmap dz  <Plug>Dsurround
nmap cz  <Plug>Csurround


"" Plug 'liuchengxu/vista.vim'
nmap !b :TagbarToggle<CR>
let s:vista_toggled = 0
" let g:vista_sidebar_position = "vertical topleft"
nmap !v :call ToggleVistaShow()<CR>   " TODO: errors out someitmes on Vista coc
nmap #v :call ToggleVistaExec()<CR>

function ToggleVistaShow()
  if s:vista_toggled == 1
    :Vista!!
  else
    :Vista show
  endif

  let s:vista_toggled = !s:vista_toggled
endfunction

function ToggleVistaExec()
  if g:vista_default_executive == 'coc'
    let g:vista_default_executive = 'ctags'
  else
    let g:vista_default_executive = 'coc'
  endif
  echo 'toggled Vista exec to ' .  g:vista_default_executive 
endfunction

autocmd WinEnter * call s:CloseIfOnlyVistaLeft()
function s:CloseIfOnlyVistaLeft()
  echo "beep"
    if bufwinnr("__vista__") != -1 " found through :echo bufname()
      if winnr("$") == 1
        q
      endif
  endif
endfunction

"" Plug 'svermeulen/vim-macrobatics'
" Use <nowait> to override the default bindings which wait for another key press
nmap <nowait> <leader>q <plug>(Mac_Play)
nmap <nowait> <leader>qr <plug>(Mac_RecordNew)

nmap <leader>mh :DisplayMacroHistory<cr>

nmap [m <plug>(Mac_RotateBack)
nmap ]m <plug>(Mac_RotateForward)

nmap <leader>ma <plug>(Mac_Append)
nmap <leader>mp <plug>(Mac_Prepend)

nmap <leader>mng <plug>(Mac_NameCurrentMacro)
nmap <leader>mnf <plug>(Mac_NameCurrentMacroForFileType)
nmap <leader>mns <plug>(Mac_NameCurrentMacroForCurrentSession)

nmap <leader>mo <plug>(Mac_SearchForNamedMacroAndOverwrite)
nmap <leader>mr <plug>(Mac_SearchForNamedMacroAndRename)
nmap <leader>md <plug>(Mac_SearchForNamedMacroAndDelete)
nmap <leader>me <plug>(Mac_SearchForNamedMacroAndPlay)
nmap <leader>ms <plug>(Mac_SearchForNamedMacroAndSelect)

"" Plug 'junegunn/fzf.vim'
nmap !f :Files<cr>
nmap #f :GFiles<cr>
nmap !t :Tags<cr>
nmap !g :Rg<cr>
nmap #g :call PreservedHyphenWordYankExec("Rg ")<cr>
nmap !l :BLines<cr>
nmap !L :BLinesNoSort<cr>
nmap #l :call PreservedHyphenWordYankExec("BLines '")<cr>
nmap #L :call PreservedHyphenWordYankExec("BLinesNoSort '")<cr>

command! -bang -nargs=* BLines
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}, 'right:50%'))


" \   fzf#vim#with_preview({'options': '--layout reverse  --with-nth=-1.. --delimiter="/"'}, 'right:50%'))

command! -bang -nargs=* BLinesNoSort
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --no-sort --with-nth=4.. --delimiter=":"'}, 'right:50%'))

function PreservedHyphenWordYankExec(command)
  " calls a:command with yiw at this cursor that includes
  " hyphens. The yank is preserved and does not affect
  " the user's registers
  let save_cb = &cb
  let l:register = '"'
  let reginfo = getreginfo(l:register)
  try
    call YankWordWithHyphen()
    let l:cmd = ":" . a:command . getreg('"')
    echo l:cmd
    exec l:cmd
    call setreg(l:register, reginfo)
  endtry
endfunction

function YankWordWithHyphen()
    " include hyphens as word symbol temporarily
    let l:includes_hyphen=stridx(&iskeyword, ',-')
    if l:includes_hyphen == -1
      set iskeyword+=-
    endif

    norm! yiw

    " restore iskeyword
    if l:includes_hyphen == -1
      set iskeyword-=-
    endif
endfunction

" Plug 'antoinemadec/coc-fzf'
nmap !o :CocFzfList outline<cr>
nmap !d :CocFzfList diagnostics<cr>


"" Plug 'neoclide/coc.nvim'
" remap <C-i> which is taken by tab for completion
nnoremap <C-p> <C-i>
nnoremap <leader>o <C-i>
"
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

nmap <leader>fc :CocFzfList<CR>

call plug#end()


""""""""""""""""""""""""""""""
" Other configs
""""""""""""""""""""""""""""""

" write permision-protected file
nmap ,ws  :w !sudo tee % > /dev/null

" tabstop set to 2 or 4
nmap ,ts2 :set tabstop=2<cr>
nmap ,ts4 :set tabstop=4<cr>

" Hex read
nmap <Leader>hr :%!xxd<CR> :set filetype=xxd<CR>
" Hex write
nmap <Leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>

" map scrolling
map <silent> <C-j> <C-e>
map <silent> <C-k> <C-y>

"" Etcnnmap <silent> <C-p> <C-i>
map <silent> <C-p> <C-i>

colo gruvbox
let g:gruvbox_contrast_dark="hard"
set background=dark
set t_Co=256

set nu rnu

filetype plugin on
syntax on

set foldmethod=indent
set nofoldenable

set tabstop=2
set shiftwidth=0

set expandtab
set autoindent

" override defaults to this script
source ~/.vimrc.local

