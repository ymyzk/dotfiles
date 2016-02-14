" CoffeeScript
if v:version >= 704
    au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
    NeoBundleLazy 'kchmck/vim-coffee-script', {
                \     'autoload': {'filetypes': ['coffee']}
                \  }
endif
