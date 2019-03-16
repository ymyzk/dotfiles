augroup filetypes
  autocmd!
  autocmd BufRead,BufNewFile .jshintrc set filetype=javascript
  " Needs plugin
  autocmd BufRead,BufNewFile *.coffee set filetype=coffee
  autocmd BufRead,BufNewFile *.es6 set filetype=javascript
  autocmd BufRead,BufNewFile *.nasm set filetype=nasm
  autocmd BufRead,BufNewFile *.otex set filetype=tex
  autocmd BufRead,BufNewFile *.podspec set filetype=ruby
  autocmd BufRead,BufNewFile *.pyi set filetype=python
  " Needs plugin
  autocmd BufRead,BufNewFile *.rkt set filetype=racket
  autocmd BufRead,BufNewFile *.sc set filetype=c
  autocmd BufRead,BufNewFile *.tc set filetype=c
  " Needs plugin
  autocmd BufRead,BufNewFile *.ts set filetype=typescript
  autocmd BufRead,BufNewFile *.webapp set filetype=json
  autocmd BufRead,BufNewFile Brewfile set filetype=ruby
  autocmd BufRead,BufNewFile Pipfile set filetype=toml
  autocmd BufRead,BufNewFile Podfile set filetype=ruby
augroup END

autocmd FileType gitcommit setlocal spell
