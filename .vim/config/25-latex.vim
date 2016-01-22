" Vim-LaTeX
NeoBundleLazy 'https://github.com/vim-latex/vim-latex.git', {
            \     'autoload': {'filetypes': ['tex']}
            \  }

" Vim-LaTeX settings
let s:bundle = neobundle#get("vim-latex")
function! s:bundle.hooks.on_source(bundle)
    let OSTYPE = system('uname')
    if OSTYPE == "Darwin\n"
        set shellslash
        set grepprg=grep\ -nH\ $*
        let g:tex_flavor='latex'
        let g:Imap_UsePlaceHolders = 1
        let g:Imap_DeleteEmptyPlaceHolders = 1
        let g:Imap_StickyPlaceHolders = 0
        let g:Tex_DefaultTargetFormat = 'pdf'
        let g:Tex_MultipleCompileFormats='dvi,pdf'
        let g:Tex_FormatDependency_pdf = 'dvi,pdf'
        let g:Tex_FormatDependency_ps = 'dvi,ps'
        let g:Tex_CompileRule_pdf = '/Library/TeX/texbin/ptex2pdf -u -l -ot "-synctex=1 -interaction=nonstopmode -file-line-error-style" $*'
        let g:Tex_CompileRule_ps = '/Library/TeX/texbin/dvips -Ppdf -o $*.ps $*.dvi'
        let g:Tex_CompileRule_dvi = '/Library/TeX/texbin/uplatex -synctex=1 -interaction=nonstopmode -file-line-error-style $*'
        let g:Tex_BibtexFlavor = '/Library/TeX/texbin/upbibtex'
        let g:Tex_MakeIndexFlavor = '/Library/TeX/texbin/mendex -U $*.idx'
        let g:Tex_UseEditorSettingInDVIViewer = 1
        let g:Tex_ViewRule_dvi = '/usr/bin/open -a Preview'
        let g:Tex_ViewRule_pdf = '/usr/bin/open -a Skim'
    elseif OSTYPE == "Linux\n"
        set shellslash
        set grepprg=grep\ -nH\ $*
        let g:tex_flavor='latex'
        let g:Imap_UsePlaceHolders = 1
        let g:Imap_DeleteEmptyPlaceHolders = 1
        let g:Imap_StickyPlaceHolders = 0
        let g:Tex_DefaultTargetFormat = 'pdf'
        let g:Tex_FormatDependency_pdf = 'dvi,pdf'
        let g:Tex_FormatDependency_ps = 'dvi,ps'
        let g:Tex_CompileRule_dvi = '/usr/bin/platex -shell-escape -interaction=nonstopmode $*'
        let g:Tex_CompileRule_pdf = '/usr/bin/dvipdfmx $*.dvi'
        let g:Tex_BibtexFlavor = '/usr/bin/pbibtex'
        let g:Tex_ViewRule_dvi = '/usr/bin/gnome-open'
        let g:Tex_ViewRule_pdf = '/usr/bin/gnome-open'
    endif
    " conceal を無効化
    let g:tex_conceal = ""
endfunction
unlet s:bundle
