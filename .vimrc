" Vi 互換モードをオフ
set nocompatible

" 256色モード
" colorscheme よりも前に書くこと
set t_Co=256

" シンタックスハイライトを有効化
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

" エンコーディング設定
" Vim 内部のエンコーディング
set encoding=utf-8
" ファイルを開く際のエンコーディング
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1

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
    " .nasm の Syntax highlight を設定
    autocmd BufRead,BufNewFile *.nasm set filetype=nasm
    " .tc の Syntax highlight を設定
    autocmd BufRead,BufNewFile *.tc set filetype=c
augroup END

" NeoBundle
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
" vimproc
NeoBundle 'Shougo/vimproc', {
            \ 'build': {
            \     'windows': 'make -f make_mingw32.mak',
            \     'cygwin': 'make -f make_cygwin.mak',
            \     'mac': 'make -f make_mac.mak',
            \     'unix': 'make -f make_unix.mak',
            \    },
            \ }

" ZenCoding
NeoBundle 'mattn/emmet-vim'
" surround
NeoBundle 'tpope/vim-surround'
" Color scheme
NeoBundle 'tomasr/molokai'
" My bundle
NeoBundle 'ymyzk/dotvim'

" HTML5 ominicomplete & syntax
NeoBundleLazy 'othree/html5.vim', {
            \     'autoload': {'filetypes': ['html']}
            \  }
" CSS3 syntax
NeoBundleLazy 'hail2u/vim-css3-syntax', {
            \     'autoload': {'filetypes': ['css']}
            \  }
" Coq syntax
NeoBundleLazy 'jvoorhis/coq.vim', {
            \     'autoload': {'filetypes': ['coq']}
            \  }
" coqtop
NeoBundleLazy 'ymyzk/coqtop-vim', {
            \     'autoload': {'filetypes': ['coq']}
            \  }
" QuickRun
NeoBundleLazy 'thinca/vim-quickrun', {
            \     'autoload': {'commands': ['QuickRun']}
            \  }
" vim-ref
NeoBundleLazy 'thinca/vim-ref', {
            \     'autoload': {'commands': ['Ref']}
            \  }
" Unite
NeoBundleLazy 'Shougo/unite.vim', {
            \     'autoload': {'commands': ['Unite']}
            \  }
" Vim-LaTeX
NeoBundleLazy 'git://git.code.sf.net/p/vim-latex/vim-latex', {
            \     'autoload': {'filetypes': ['tex']}
            \  }
" neosnippet.vim
NeoBundleLazy 'Shougo/neosnippet.vim', {
            \     'autoload': {'insert': 1}
            \  }
" neosnippet-snippets
NeoBundleLazy 'Shougo/neosnippet-snippets', {
            \     'autoload': {'insert': 1}
            \  }
" CoffeeScript
if v:version >= 704
    au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
    NeoBundleLazy 'kchmck/vim-coffee-script', {
                \     'autoload': {'filetypes': ['coffee']}
                \  }
endif
" Powerline
if has('python') || has('python3')
    NeoBundle 'Lokaltog/powerline', {'rtp' : 'powerline/bindings/vim'}
    set noshowmode
endif

" Auto completion
if has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
    " neocomplete
    NeoBundleLazy 'Shougo/neocomplete.vim', {
                \     'autoload': {'insert': 1}
                \  }
    let s:bundle = neobundle#get("neocomplete.vim")
    function! s:bundle.hooks.on_source(bundle)
        "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
        " Disable AutoComplPop.
        let g:acp_enableAtStartup = 0
        " Use neocomplete.
        let g:neocomplete#enable_at_startup = 1
        " Use smartcase.
        let g:neocomplete#enable_smart_case = 1
        " Set minimum syntax keyword length.
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

        " Define dictionary.
        let g:neocomplete#sources#dictionary#dictionaries = {
                    \ 'default' : '',
                    \ 'vimshell' : $HOME.'/.vimshell_hist',
                    \ 'scheme' : $HOME.'/.gosh_completions'
                    \ }

        " Define keyword.
        if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
        endif
        let g:neocomplete#keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        inoremap <expr><C-g>     neocomplete#undo_completion()
        inoremap <expr><C-l>     neocomplete#complete_common_string()

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
            return neocomplete#close_popup() . "\<CR>"
            " For no inserting <CR> key.
            "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplete#close_popup()
        inoremap <expr><C-e>  neocomplete#cancel_popup()
        " Close popup by <Space>.
        "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

        " For cursor moving in insert mode(Not recommended)
        "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
        "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
        "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
        "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
        " Or set this.
        "let g:neocomplete#enable_cursor_hold_i = 1
        " Or set this.
        "let g:neocomplete#enable_insert_char_pre = 1

        " AutoComplPop like behavior.
        "let g:neocomplete#enable_auto_select = 1

        " Shell like behavior(not recommended).
        "set completeopt+=longest
        "let g:neocomplete#enable_auto_select = 1
        "let g:neocomplete#disable_auto_complete = 1
        "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        if !exists('g:neocomplete#sources#omni#input_patterns')
            let g:neocomplete#sources#omni#input_patterns = {}
        endif
        "let g:neocomplete#sources#omni#input_patterns.php = '[^.\t]->\h\w*\|\h\w*::'
        "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

        " For perlomni.vim setting.
        " https://github.com/c9s/perlomni.vim
        let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    endfunction
    unlet s:bundle
else
    " neocomplcache
    NeoBundleLazy 'Shougo/neocomplcache.vim', {
                \     'autoload': {'insert': 1}
                \  }
    let s:bundle = neobundle#get("neocomplcache.vim")
    function! s:bundle.hooks.on_source(bundle)
        " Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
        " Disable AutoComplPop.
        let g:acp_enableAtStartup = 0
        " Use neocomplcache.
        let g:neocomplcache_enable_at_startup = 1
        " Use smartcase.
        let g:neocomplcache_enable_smart_case = 1
        " Set minimum syntax keyword length.
        let g:neocomplcache_min_syntax_length = 3
        let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

        " Enable heavy features.
        " Use camel case completion.
        "let g:neocomplcache_enable_camel_case_completion = 1
        " Use underbar completion.
        "let g:neocomplcache_enable_underbar_completion = 1

        " Define dictionary.
        let g:neocomplcache_dictionary_filetype_lists = {
                    \ 'default' : '',
                    \ 'vimshell' : $HOME.'/.vimshell_hist',
                    \ 'scheme' : $HOME.'/.gosh_completions'
                    \ }

        " Define keyword.
        if !exists('g:neocomplcache_keyword_patterns')
            let g:neocomplcache_keyword_patterns = {}
        endif
        let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

        " Plugin key-mappings.
        inoremap <expr><C-g>     neocomplcache#undo_completion()
        inoremap <expr><C-l>     neocomplcache#complete_common_string()

        " Recommended key-mappings.
        " <CR>: close popup and save indent.
        inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
        function! s:my_cr_function()
            "return neocomplcache#smart_close_popup() . "\<CR>"
            " For no inserting <CR> key.
            return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
        endfunction
        " <TAB>: completion.
        inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
        " <C-h>, <BS>: close popup and delete backword char.
        inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
        inoremap <expr><C-y>  neocomplcache#close_popup()
        inoremap <expr><C-e>  neocomplcache#cancel_popup()
        " Close popup by <Space>.
        "inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

        " For cursor moving in insert mode(Not recommended)
        "inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
        "inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
        "inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
        "inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
        " Or set this.
        "let g:neocomplcache_enable_cursor_hold_i = 1
        " Or set this.
        "let g:neocomplcache_enable_insert_char_pre = 1

        " AutoComplPop like behavior.
        "let g:neocomplcache_enable_auto_select = 1

        " Shell like behavior(not recommended).
        "set completeopt+=longest
        "let g:neocomplcache_enable_auto_select = 1
        "let g:neocomplcache_disable_auto_complete = 1
        "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

        " Enable omni completion.
        autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
        autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
        autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
        autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
        autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

        " Enable heavy omni completion.
        if !exists('g:neocomplcache_omni_patterns')
            let g:neocomplcache_omni_patterns = {}
        endif
        let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
        let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
        let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

        " For perlomni.vim setting.
        " https://github.com/c9s/perlomni.vim
        let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
    endfunction
    unlet s:bundle
endif

call neobundle#end()

" ファイル形式別インデントとプラグインを有効化
" NeoBundle で必要
filetype indent plugin on

" Installation check.
NeoBundleCheck

" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Color scheme
colorscheme molokai

" QuickRun settings
let s:bundle = neobundle#get("vim-quickrun")
function! s:bundle.hooks.on_source(bundle)
    " デフォルトで vimproc を使って非同期で実行する
    let g:quickrun_config = {
                \   "_" : {
                \       "runner" : "vimproc",
                \       "runner/vimproc/updatetime" : 60
                \   },
                \   "c": {
                \      "cmdopt" : "-std=c99"
                \   }
                \}
endfunction
unlet s:bundle

" Vim-LaTeX settings
let s:bundle = neobundle#get("vim-latex")
function! s:bundle.hooks.on_source(bundle)
    let OSTYPE = system('uname')
    if OSTYPE == "Darwin\n"
        set shellslash
        set grepprg=grep\ -nH\ $*
        let g:tex_flavor='latex'
        let g:Imap_UsePlaceHolders = 1
        let g:Imap_DeleteEmptyPlaceHolders = 1
        let g:Imap_StickyPlaceHolders = 0
        let g:Tex_DefaultTargetFormat = 'pdf'
        let g:Tex_MultipleCompileFormats='dvi,pdf'
        let g:Tex_FormatDependency_pdf = 'dvi,pdf'
        let g:Tex_FormatDependency_ps = 'dvi,ps'
        let g:Tex_CompileRule_pdf = '/usr/texbin/ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
        let g:Tex_CompileRule_ps = '/usr/texbin/dvips -Ppdf -o $*.ps $*.dvi'
        let g:Tex_CompileRule_dvi = '/usr/texbin/uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        let g:Tex_BibtexFlavor = '/usr/texbin/upbibtex'
        let g:Tex_MakeIndexFlavor = '/usr/texbin/mendex -U $*.idx'
        let g:Tex_UseEditorSettingInDVIViewer = 1
        let g:Tex_ViewRule_dvi = '/usr/bin/open -a Preview'
        let g:Tex_ViewRule_pdf = '/usr/bin/open -a Preview'
    elseif OSTYPE == "Linux\n"
        set shellslash
        set grepprg=grep\ -nH\ $*
        let g:tex_flavor='latex'
        let g:Imap_UsePlaceHolders = 1
        let g:Imap_DeleteEmptyPlaceHolders = 1
        let g:Imap_StickyPlaceHolders = 0
        let g:Tex_DefaultTargetFormat = 'pdf'
        let g:Tex_FormatDependency_pdf = 'dvi,pdf'
        let g:Tex_FormatDependency_ps = 'dvi,ps'
        let g:Tex_CompileRule_dvi = '/usr/bin/platex -shell-escape -interaction=nonstopmode $*'
        let g:Tex_CompileRule_pdf = '/usr/bin/dvipdfmx $*.dvi'
        let g:Tex_BibtexFlavor = '/usr/bin/pbibtex'
        let g:Tex_ViewRule_dvi = '/usr/bin/gnome-open'
        let g:Tex_ViewRule_pdf = '/usr/bin/gnome-open'
    endif
endfunction
unlet s:bundle

let s:bundle = neobundle#get("neosnippet.vim")
function! s:bundle.hooks.on_source(bundle)
    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    " SuperTab like snippets behavior.
    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: pumvisible() ? "\<C-n>" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
                \ "\<Plug>(neosnippet_expand_or_jump)"
                \: "\<TAB>"

    " For snippet_complete marker.
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif
endfunction
unlet s:bundle

" on_source を実行
call neobundle#call_hook("on_source")
