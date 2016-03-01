" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

" Color scheme
colorscheme molokai
"let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
" カーソル行の背景色を変える
set cursorline
