set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=79 
set expandtab 
set autoindent 
set foldmethod=indent
set foldnestmax=3
set foldignore=~
" in exists, '*' means function name
if !exists("*s:PySetMain")
    func s:PySetMain()
        if &filetype == 'python'
            "call setline(1,"`timescale 1ns/1ps")
            "call setline(5,"")
            call setline(1,"#! $PATH/python")
            call setline(2,"")
            call setline(3,"# file name: ".expand("%c"))
            call setline(4,"# author: lianghy")
            call setline(5,"# time: ".strftime("%c"))
            call setline(6,"")
            call setline(7,"if __name__==\"__main__\":")
            call setline(8,"    print(\"".expand("%c")."\")")
        endif
    endfunc
    func PyDefFunc() abort
            return pumvisible() ? "\<c-e>" : ''
    endfunc
endif

function! s:dyPyInit()
    execute "normal! odef __init__(self):"
endfunction

func! AddHead()
    call s:PySetMain()
endfunc

func! s:createUnitTest()
    call setline(1,"class testClass:")
    call setline(2,"    def setup(self):")
    call setline(3,"        pass")
    call setline(4,"    def tearDown(self):")
    call setline(5,"        pass")
    call setline(6,"    def test_c1(self):")
    call setline(7,"        pass")
    call setline(8,"")
    call setline(9,"for test_method in get_test_classes():")
    call setline(10,"    obj = testClass()")
    call setline(11,"    obj.setup()")
    call setline(12,"    try:")
    call setline(13,"        obj.test_method()")
    call setline(14,"    finally:")
    call setline(15,"        obj.tearDown()")
endfunc
noremap <C-d>init :call <SID>dyPyInit()<cr>
noremap <C-d>test :call <SID>createUnitTest()<cr>

