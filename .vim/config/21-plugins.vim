" vimproc
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'tools\\update-dll-mingw',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make -f make_mac.mak',
            \     'linux' : 'make',
            \     'unix' : 'gmake',
            \    },
            \ }

" ZenCoding
NeoBundle 'mattn/emmet-vim'
" surround
NeoBundle 'tpope/vim-surround'
" Color scheme
NeoBundle 'tomasr/molokai'
" lightline
NeoBundle 'itchyny/lightline.vim'

" coqtop
NeoBundleLazy 'ymyzk/coqtop-vim', {
            \     'autoload': {'filetypes': ['coq']}
            \  }
" vim-ref
NeoBundleLazy 'thinca/vim-ref', {
            \     'autoload': {'commands': ['Ref']}
            \  }
" Unite
NeoBundleLazy 'Shougo/unite.vim', {
            \     'autoload': {'commands': ['Unite']}
            \  }
" QuickRun
NeoBundleLazy 'thinca/vim-quickrun', {
            \     'autoload': {'commands': ['QuickRun']}
            \  }

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
