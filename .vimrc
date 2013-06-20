set nocompatible


" NeoBundle

filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
"NeoBundle 'Shougo/vimproc

" My Bundles here:
"
" Note: You don't set neobundle setting in .gvimrc!
" Original repos on github
"

" Color scheme
NeoBundle 'tomasr/molokai'


" Features

filetype indent plugin on

syntax on


" Must have options

set hidden

set wildmenu

set showcmd

set hlsearch

"set nomodeline

" Usability options

set ignorecase
set smartcase

set backspace=indent,eol,start

set autoindent

set nostartofline

set ruler

set laststatus=2

set confirm

set visualbell

set t_vb=

set mouse=a

set cmdheight=1 "2

set number

set notimeout ttimeout ttimeoutlen=200

set pastetoggle=<F11>


" Indentation options

set shiftwidth=4
set softtabstop=4
set expandtab

"set shiftwidth=4
"set tabstop=4


" Color scheme

colorscheme molokai

" Visual options

set list

" set listchars=eol:↲,tab:>\ ,trail:-,extends:»,precedes:«,nbsp:%
set listchars=tab:»\ ,trail:-,extends:»,precedes:«,nbsp:%

set cursorline


" Auto complete

function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<TAB>"
    else
        if pumvisible()
            return "\<C-N>"
        else
            return "\<C-N>\<C-P>"
        end
    endif
endfunction

inoremap <tab> <c-r>=InsertTabWrapper()<cr>


" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
NeoBundleCheck

