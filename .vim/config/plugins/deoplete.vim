" Enable omni completion
if !exists('g:deoplete#omni_patterns')
  let g:deoplete#omni_patterns = {}
endif

" For merlin
let g:deoplete#omni_patterns.ocaml = '[^. *\t]\.\w*\|\h\w*|#'
