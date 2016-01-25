call neobundle#end()

" ファイル形式別インデントとプラグインを有効化
" Required:
filetype indent plugin on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" on_source を実行
call neobundle#call_hook("on_source")

" Color scheme
colorscheme molokai
"let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
" カーソル行の背景色を変える
set cursorline
