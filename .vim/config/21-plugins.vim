augroup MyAutoCmd
  autocmd!
augroup END

if dein#tap('caw.vim')
  nmap <Leader>c <Plug>(caw:i:toggle)
  vmap <Leader>c <Plug>(caw:i:toggle)
endif

if dein#tap('vim-quickrun')
  function! s:quickrun_on_source() abort
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
  execute 'autocmd MyAutoCmd User' 'dein#source#'.g:dein#name
        \ 'call s:quickrun_on_source()'
endif
