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
" CoffeeScript
if v:version >= 704
    au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
    NeoBundleLazy 'kchmck/vim-coffee-script', {
                \     'autoload': {'filetypes': ['coffee']}
                \  }
endif
