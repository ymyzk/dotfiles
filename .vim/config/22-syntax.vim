" HTML5 ominicomplete & syntax
NeoBundleLazy 'othree/html5.vim', {
            \     'autoload': {'filetypes': ['html', 'htmldjango']}
            \  }
" CSS3 syntax
NeoBundleLazy 'hail2u/vim-css3-syntax', {
            \     'autoload': {'filetypes': ['css']}
            \  }
" for vim-jsx
NeoBundle 'pangloss/vim-javascript', {
            \     'autoload': {'filetypes': ['javascript']}
            \  }
" React JSX
NeoBundle 'mxw/vim-jsx', {
            \     'autoload': {'filetypes': ['javascript.jsx']}
            \  }
" Coq syntax
NeoBundleLazy 'jvoorhis/coq.vim', {
            \     'autoload': {'filetypes': ['coq']}
            \  }
" Scala
NeoBundleLazy 'derekwyatt/vim-scala', {
            \     'autoload': {'filetypes': ['scala']}
            \  }
" CoffeeScript
if v:version >= 704
    au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
    NeoBundleLazy 'kchmck/vim-coffee-script', {
                \     'autoload': {'filetypes': ['coffee']}
                \  }
endif
