if exists("b:did_mpy_ftplugin")
  finish
endif
let b:did_mpy_ftplugin = 1  " Don't load another plugin for this buffer
"set tabstop=4 
"set softtabstop=4 
"set shiftwidth=4
"set expandtab 
set foldmethod=indent
set foldnestmax=7
set noautoindent 
set guifont=Fira_Code:h14
"set foldlevelstart=99
"set foldignore=~

let g:ale_linters = {'python' : ['pylint'],}

" in exists, '*' means function name
if !exists("*s:PySetMain")
    func s:PySetMain()
        "if &filetype == 'python'
            call setline(1,"#! $PATH/python")
            call setline(2,"# -*- coding: utf-8 -*-")
            call setline(3,"")
            call setline( 4,"")
            call setline( 5,'""" """')
            call setline( 6,"")
            call setline( 7,"if __name__ == \"__main__\":")
            call setline( 8,"    print(\"".expand("%c")."\")")
        "endif
    endfunc
    func PyDefFunc() abort
            return pumvisible() ? "\<c-e>" : ''
    endfunc
endif

function! s:createPyMTL()
    call setline(1,"#===========================================================================")
    call setline(2,"# ")
    call setline(3,"#===========================================================================")
    call setline(4,"#")
    call setline(5,"#")
endfunction

function! s:dyPyInit()
    execute "normal! odef __init__(self):"
endfunction

func! AddHead()
    call s:PySetMain()
endfunc

func! s:createUnitTest()
    let line_num = line('.')
    call append(line_num, "")
    call append(line_num, "        pass")
    call append(line_num, "    def test_c1(self):")
    call append(line_num, "        pass")
    call append(line_num, "    def tearDown(self):")
    call append(line_num, "        pass")
    call append(line_num, "    def setup(self):")
    call append(line_num, "class Test:")
    call append(line_num, "import ")
    call append(line_num, "sys.path.append('..')")
    call append(line_num, "import sys")
    call append(line_num, "")
endfunc

noremap <C-e>init :call <SID>dyPyInit()<cr>
noremap <C-e>test :call <SID>createUnitTest()<cr>
noremap <C-e>mtl :call <SID>createPyMTL()<cr>
noremap <SPACE> o""" """<Esc>
nnoremap <silent> <buffer> <cr> :PythonSearchContext<cr>
