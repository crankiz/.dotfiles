"     ________ ++     ________
"    /VVVVVVVV\++++  /VVVVVVVV\
"    \VVVVVVVV/++++++\VVVVVVVV/
"     |VVVVVV|++++++++/VVVVV/'
"     |VVVVVV|++++++/VVVVV/'
"    +|VVVVVV|++++/VVVVV/'+
"  +++|VVVVVV|++/VVVVV/'+++++
"+++++|VVVVVV|/VVV___++++++++++
"  +++|VVVVVVVVVV/##/ +_+_+_+_
"    +|VVVVVVVVV___ +/#_#,#_#,\
"     |VVVVVVV//##/+/#/+/#/'/#/
"     |VVVVV/'+/#/+/#/+/#/ /#/
"     |VVV/'++/#/+/#/ /#/ /#/
"     'V/'  /##//##//##//###/   RC
"              ++
""""""""""""""""""""""""""""""""""""""
" Auto refresh .vimrc
if has("autocmd")
    autocmd bufwritepost .vimrc source $MYVIMRC
  endif

" Filetype detection
filetype plugin indent on

" File autocompletion | ctrl+x & ctrl+f

" Colorscheme
syntax on
set background=dark
"colorscheme koehler
set laststatus=2
hi statusline guibg=DarkGrey ctermfg=8

" Line number
set number relativenumber
set numberwidth=3
set cpoptions+=n
highlight LineNr ctermfg=darkgrey

" Tab, spaces, nesting
set softtabstop=2
"set expandtab
set smartindent
"set autoindent

" Commands
  " Quiting failsef
  command! Wq :wq
  command! WQ :wq

" Return to the same line when you reopen a file
augroup line_return
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif
augroup END


" Automatic paste mode
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction


" Auto close bracet
" inoremap " ""<Esc>i
" inoremap ' ''<Esc>i
" inoremap { {}<Esc>i
" inoremap ( ()<Esc>i
" inoremap [ []<Esc>i

" No bell sound
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
