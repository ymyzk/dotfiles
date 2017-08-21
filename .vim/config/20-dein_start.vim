"dein Scripts-----------------------------
augroup MyAutoCmd
  autocmd!
augroup END

let s:base_path = expand('~/.cache/dein.vim')
let s:dein_path = s:base_path . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_path)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_path
endif
execute 'set runtimepath^=' . substitute(fnamemodify(s:dein_path, ':p') , '/$', '', '')

if dein#load_state(s:base_path)
  let s:toml_path = '~/.vim/config/dein.toml'
  let s:toml_lazy_path = '~/.vim/config/deinlazy.toml'

  call dein#begin(s:base_path, [expand('<sfile>'), s:toml_path, s:toml_lazy_path])

  call dein#load_toml(s:toml_path, {'lazy': 0})
  call dein#load_toml(s:toml_lazy_path, {'lazy': 1})

  let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
  let s:merlin_path = g:opamshare . "/merlin/vim"
   if isdirectory(s:merlin_path)
     call dein#add(s:merlin_path, {'lazy': 1, 'on_ft': 'merlin', 'on_event': 'InsertEnter'})
     call dein#add(s:merlin_path, {'lazy': 1, 'on_ft': 'ocaml', 'on_event': 'InsertEnter'})
  endif

  " call dein#local('~/Development',
  "             \ {
  "             \   'frozen' : 1
  "             \ }, ["vim-copl"])

  call dein#end()
  call dein#save_state()
endif

"let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
" カーソル行の背景色を変える
set cursorline
colorscheme molokai

filetype plugin indent on

" If you want to install not installed plugins on startup.
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
