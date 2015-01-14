if &compatible
    set nocompatible
endif

" Encodings
" Vim
set encoding=utf-8
" Vim script encoding
scriptencoding utf-8
" ファイルを開く際のエンコーディング
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1

" 256色モード
" colorscheme よりも前に書くこと
set t_Co=256

syntax on

" 保存しなくてもファイルを切り替えられるようにする
set hidden
" コマンドラインモードでの補完
set wildmenu
" コマンドをステータスラインに表示
set showcmd
" Backspace キーの設定
" autoindent, 行末, 挿入区間の始めで働かせる
set backspace=indent,eol,start
" ファイルを保存していないときに, ファイル保存を確認する
set confirm
" ビープ音の代わりに画面をフラッシュ
set visualbell
" 画面フラッシュもオフにする
set t_vb=
" すべてのモードでマウスを有効
set mouse=a
" マッピングはタイムアウトなし
" キーコードはタイムアウトあり
set notimeout ttimeout ttimeoutlen=200

" スワップ設定
" スワップファイルを作成
set swapfile
" スワップファイルの生成先を設定
set directory=.,~/tmp,/var/tmp,/tmp

" バックアップ設定
" 上書きに失敗した場合のみバックアップをとる
set nobackup
set writebackup
" バックアップファイルの保存先を設定
set backupdir=.,~/tmp,~/

" 検索設定
" 検索結果のハイライト
set hlsearch
" インクリメンタルサーチ
set incsearch
" 小文字なら大文字を無視, 大文字なら大文字を無視せずに検索
set smartcase
" 大文字/小文字を無視して検索
"set ignorecase

" 表示設定
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの行数
set cmdheight=1
" カーソル位置を表示
" Powerline では不要?
set ruler
" 行番号を表示
set number
" カーソル行の背景色を変える
set cursorline
" ウィンドウの最後の行を省略せずに表示する
set display=lastline

" インデント設定
" 改行時の自動インデントとスマートインデントを有効化
set autoindent smartindent
" インデントの空白の数
set shiftwidth=4
" Tab による空白の数
set softtabstop=4
" Tab を空白にする
" Tab を入力する際は Ctrl+V <Tab>
set expandtab

" 不可視文字設定
" 不可視文字を表示
set list
" 不可視文字のフォーマット
set listchars=tab:»\ ,trail:-,extends:»,precedes:«,nbsp:%

" ヒストリーの件数
set history=256

" autocmd
" ファイル全般に設定
augroup general
    autocmd!
    function! s:saveView()
        " バッファがファイルでない場合と Git のコミットメッセージの場合は除外
        if expand('%') != '' && &buftype !~ 'nofile' && !(bufname("%") =~ '\(COMMIT_EDITMSG\)')
            mkview
        endif
    endfunction
    " カーソル位置などを保存
    autocmd BufWinLeave * call s:saveView()
    autocmd BufWinEnter * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
    " ファイル保存時のみカーソル位置などを保存する場合は以下を用いる
    "autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
    "autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
    " バッファのオプションは保存しない
    set viewoptions-=options
augroup END

runtime! config/*.vim
