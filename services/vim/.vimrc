call plug#begin()
" Download vim.plug to ~/.vim/autoload from github.com/junegunn/vim-plug:
" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" run :PlugInstall to install plugins. 

""""""""""""""""""""""""""""""
" plugin List
""""""""""""""""""""""""""""""

Plug 'preservim/nerdtree'                           " see config below
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim'                              " see config below
Plug 'chrisbra/Recover.vim'                         
"Plug 'yggdroot/indentLine'
  " visualizes indent lines
Plug 'justinmk/vim-sneak'                           " see config below
  " 's' to jump to any location specified by two characters
Plug 'tpope/vim-repeat'
Plug 'svermeulen/vim-macrobatics'                   " see config below

"" Intellisence & Autocomplete & Syntax Highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'}     " see config below


"" ------------------- Plug Config -------------------------

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

"" Plug 'junegunn/fzf.vim'
nmap !f :Files<cr>
nmap #f :GFiles<cr>
nmap !t :Tags<cr>
nmap !g :call SaveToJumplistIfOK("Rg")<cr>
nmap #g :call PreservedHyphenWordYankExec("Rg ")<cr>
nmap !l :call SaveToJumplistIfOK("BLines")<cr>
nmap !L :call SaveToJumplistIfOK("BLinesNoSort")<cr>
nmap #l :call PreservedHyphenWordYankExec("BLines '")<cr>
nmap #L :call PreservedHyphenWordYankExec("BLinesNoSort '")<cr>

let g:fzf_preview_window = ['up:60%', 'ctrl-/']

command! -bang -nargs=* BLines
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --with-nth=4.. --delimiter=":"'}, 'down:60%'))


" \   fzf#vim#with_preview({'options': '--layout reverse  --with-nth=-1.. --delimiter="/"'}, 'right:50%'))

command! -bang -nargs=* BLinesNoSort
    \ call fzf#vim#grep(
    \   'rg --with-filename --column --line-number --no-heading --smart-case . '.fnameescape(expand('%:p')), 1,
    \   fzf#vim#with_preview({'options': '--layout reverse --query '.shellescape(<q-args>).' --no-sort --with-nth=4.. --delimiter=":"'}, 'down:60%'))

function PreservedHyphenWordYankExec(command)
  " calls a:command with yiw at this cursor that includes
  " hyphens. The yank is preserved and does not affect
  " the user's registers

  " save this location to the jumplist first. see :jumps
  normal! m`

  let save_cb = &cb
  let l:register = '"'
  " let reginfo = getreginfo(l:register)
  try
    call YankWordWithHyphen()
    let l:cmd = ":" . a:command . getreg('"')
    exec l:cmd
    " call setreg(l:register, reginfo)
    call ConsumeSaveToJumplistOnError()
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

function SaveToJumplistIfOK(command)
  " save this location to the jumplist first. see :jumps
  normal! m`

  try
    let l:cmd = ":" . a:command
    exec l:cmd
  endtry

  call ConsumeSaveToJumplistOnError()
endfunction

function ConsumeSaveToJumplistOnError()
  if v:shell_error != 0
    " we canceled the command or something went wrong, undo addition to
    " jumplist. This still would cause the jump history past current point to
    " be deleted
    normal! 
    endif
endfunction



" Plug 'svermeulen/vim-macrobatics'

" Use <nowait> to override the default bindings which wait for another key
" press
nmap <nowait> q <plug>(Mac_Play)
nmap <nowait> gq <plug>(Mac_RecordNew)

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
" inoremap <silent><expr> <TAB>
"   \ pumvisible() ? "\<C-n>" :
"   \ <SID>check_back_space() ? "\<TAB>" :
"   \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" 
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1] =~# '\s'
" endfunction

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


call plug#end()


""""""""""""""""""""""""""""""
" Other configs
""""""""""""""""""""""""""""""

"set nu rnu

set foldmethod=indent
set nofoldenable
set tabstop=2
set shiftwidth=0

set expandtab
set autoindent
set nowrap

colo desert

filetype plugin on
syntax on
set t_Co=256

" Scrolling mapping
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

function! OpenFoldsUpToCursor()
  silent normal! zM

  let l:cursor_pos = getpos(".")
  let l:line_num = l:cursor_pos[1]

  while foldclosed(l:line_num) != -1
    silent normal! zo
    silent let l:cursor_pos = getpos(".")
    let l:line_num = l:cursor_pos[1]
  endwhile
endfunction

nnoremap <silent> zu :call OpenFoldsUpToCursor()<CR>

" override defaults to this script
source ~/.vimrc.local

