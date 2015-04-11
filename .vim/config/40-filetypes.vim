augroup filetypes
    autocmd!
    autocmd BufRead,BufNewFile *.nasm set filetype=nasm
    autocmd BufRead,BufNewFile *.tc set filetype=c
    autocmd BufRead,BufNewFile *.webapp set filetype=json
augroup END
