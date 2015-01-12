call neobundle#end()

" ファイル形式別インデントとプラグインを有効化
" NeoBundle で必要
filetype indent plugin on

" Installation check.
NeoBundleCheck

" on_source を実行
call neobundle#call_hook("on_source")

" Color scheme
colorscheme molokai
