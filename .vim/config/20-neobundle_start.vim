" NeoBundle
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if has('vim_starting')
    if &compatible
        " Be iMproved
        set nocompatible
    endif

    " Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

if neobundle#load_cache(
            \ expand('<sfile>'),
            \ '~/.vim/config/neobundlelazy.toml')
    " Let NeoBundle manage NeoBundle
    " Required:
    NeoBundleFetch 'Shougo/neobundle.vim'

    " call neobundle#load_toml('~/.vim/config/neobundle.toml')
    call neobundle#load_toml('~/.vim/config/neobundlelazy.toml', {'lazy' : 1})

    NeoBundleSaveCache
endif
