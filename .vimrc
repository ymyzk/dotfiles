" Vi 互換モードをオフ
set nocompatible

" 256色モード
" colorscheme よりも前に書くこと
set t_Co=256

" NeoBundle
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))

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

" Auto completion
NeoBundle 'Shougo/neocomplcache.vim'
" ZenCoding
NeoBundle 'mattn/emmet-vim'
" Color scheme
NeoBundle 'tomasr/molokai'
" My bundle
NeoBundle 'litesystems/dotvim'

" HTML5 ominicomplete & syntax
NeoBundleLazy 'othree/html5.vim', {
            \     'autoload': {'filetypes': ['html']}
            \  }
" CSS3 syntax
NeoBundleLazy 'hail2u/vim-css3-syntax', {
            \     'autoload': {'filetypes': ['css']}
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
" Powerline
if has('python') || has('python3')
    NeoBundle 'Lokaltog/powerline', {'rtp' : 'powerline/bindings/vim'}
    set noshowmode
endif

" ファイル形式別インデントとプラグインを有効化
" NeoBundle で必要
filetype indent plugin on

" Installation check.
NeoBundleCheck

" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" シンタックスハイライトを有効化
syntax on

" 保存しなくてもファイルを切り替えられるようにする
set hidden
" コマンドラインモードでの補完
set wildmenu
" コマンドをステータスラインに表示
set showcmd
" 検索結果のハイライト
set hlsearch
" 大文字/小文字を無視して検索
"set ignorecase
" 小文字なら大文字を無視, 大文字なら大文字を無視せずに検索
set smartcase
" Backspace キーの設定
" autoindent, 行末, 挿入区間の始めで働かせる
set backspace=indent,eol,start
" 改行時の自動インデント
set autoindent
" カーソル位置を表示
" Powerline では不要?
set ruler
" ステータスラインを常に表示
set laststatus=2
" ファイルを保存していないときに, ファイル保存を確認する
set confirm
" ビープ音の代わりに画面をフラッシュ
set visualbell
" 画面フラッシュもオフにする
set t_vb=
" すべてのモードでマウスを有効
set mouse=a
" コマンドラインの行数
set cmdheight=1
" 行番号を表示
set number
" マッピンングはタイムアウトなし
" キーコードはタイムアウトあり
set notimeout ttimeout ttimeoutlen=200
" インデントの空白の数
set shiftwidth=4
" Tab による空白の数
set softtabstop=4
" Tab を空白にする
" Tab を入力する際は Ctrl+V <Tab>
set expandtab
" 不可視文字を表示
set list
" 不可視文字のフォーマット
set listchars=tab:»\ ,trail:-,extends:»,precedes:«,nbsp:%
" カーソル業の背景色を変える
set cursorline

" Color scheme
colorscheme molokai

" Auto complete
" Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
let s:bundle = neobundle#get("neocomplcache.vim")
function! s:bundle.hooks.on_source(bundle)
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

" QuickRun settings
let s:bundle = neobundle#get("vim-quickrun")
function! s:bundle.hooks.on_source(bundle)
    " デフォルトで vimproc を使って非同期で実行する
    let g:quickrun_config = {
                \    "_" : {
                \        "runner" : "vimproc",
                \        "runner/vimproc/updatetime" : 60
                \    },
                \ }
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
        let g:Tex_FormatDependency_pdf = 'dvi,pdf'
        let g:Tex_FormatDependency_ps = 'dvi,ps'
        let g:Tex_CompileRule_dvi = '/usr/texbin/platex -shell-escape -interaction=nonstopmode $*'
        let g:Tex_CompileRule_pdf = '/usr/texbin/dvipdfmx $*.dvi'
        let g:Tex_BibtexFlavor = '/usr/texbin/pbibtex'
        let g:Tex_ViewRule_dvi = '/usr/bin/open -a Preview'
        let g:Tex_ViewRule_pdf = '/usr/bin/open -a Preview'
    endif
endfunction
unlet s:bundle

" on_source を実行
call neobundle#call_hook("on_source")
