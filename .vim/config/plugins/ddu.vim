" You must set the default ui.
call ddu#custom#patch_global({
    \ 'ui': 'ff',
    \ })

" You must set the default action.
" Note: file kind
" https://github.com/Shougo/ddu-kind-file
call ddu#custom#patch_global({
    \   'kindOptions': {
    \     'file': {
    \       'defaultAction': 'open',
    \     },
    \   }
    \ })

" Specify matcher.
" Note: matcher_substring filter
" https://github.com/Shougo/ddu-filter-matcher_substring
call ddu#custom#patch_global({
    \   'sourceOptions': {
    \     '_': {
    \       'matchers': ['matcher_substring'],
    \     },
    \   }
    \ })

" Set default sources
" Note: file source
" https://github.com/Shougo/ddu-source-file
call ddu#custom#patch_global({
    \   'sources': [
    \     {'name': 'file', 'params': {}},
    \     {'name': 'file_rec', 'params': {}},
    \     {'name': 'buffer', 'params': {}},
    \   ],
    \ })

" Call default sources
"call ddu#start({})

" Set name specific configuration
"call ddu#custom#patch_local('files', {
"    \ 'sources': [
"    \   {'name': 'file', 'params': {}},
"    \   {'name': 'file_old', 'params': {}},
"    \ ],
"    \ })

" Specify name
"call ddu#start({'name': 'files'})

" Specify source with params
" Note: file_rec source
" https://github.com/Shougo/ddu-source-file_rec
"call ddu#start({'sources': [
"    \ {'name': 'file_rec', 'params': {'path': expand('~')}}
"    \ ]})

nmap <silent> ;d <Cmd>call ddu#start({
            \   'ui': 'filer',
            \   'sources': [{'name': 'file'}],
            \   'uiParams': {'ff': {'startFilter': v:true}},
            \ })<CR>
nmap <silent> ;f <Cmd>call ddu#start({
            \   'sources': [{'name': 'file'}],
            \   'uiParams': {'ff': {'startFilter': v:true}},
            \ })<CR>
nmap <silent> ;b <Cmd>call ddu#start({
            \   'sources': [{'name': 'buffer'}],
            \   'uiParams': {'ff': {'startFilter': v:true}},
            \ })<CR>

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
    nnoremap <buffer><silent> <CR>
                \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
    nnoremap <buffer><silent> <Space>
                \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
    nnoremap <buffer><silent> i
                \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
    nnoremap <buffer><silent> q
                \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
    inoremap <buffer><silent> <CR>
                \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
    nnoremap <buffer><silent> <CR>
                \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
    nnoremap <buffer><silent> q
                \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-filer call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#filer#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#filer#do_action('toggleSelectItem')<CR>
  nnoremap <buffer> o
        \ <Cmd>call ddu#ui#filer#do_action('expandItem',
        \ {'mode': 'toggle'})<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#filer#do_action('quit')<CR>
endfunction
