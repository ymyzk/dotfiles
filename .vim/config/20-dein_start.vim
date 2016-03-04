"dein Scripts-----------------------------
set runtimepath^=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

let s:toml_path = '~/.vim/config/dein.toml'
let s:toml_lazy_path = '~/.vim/config/deinlazy.toml'
if dein#load_cache([expand('<sfile>'), s:toml_path, s:toml_lazy_path])
  call dein#load_toml(s:toml_path, {'lazy': 0})
  call dein#load_toml(s:toml_lazy_path, {'lazy' : 1})

  call dein#save_cache()
endif
