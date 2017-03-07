if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1  " Don't load another plugin for this buffer
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
        "if &filetype == 'python'
            "call setline(1,"`timescale 1ns/1ps")
            "call setline(5,"")
            call setline(1,"#! $PATH/python")
            call setline(2,"")
            call setline(3,"# file name: ".expand("%c"))
            call setline(4,"# author: lianghy")
            call setline(5,"# time: ".strftime("%c"))
            call setline(6,"")
            call setline(7,"if __name__ == \"__main__\":")
            call setline(8,"    print(\"".expand("%c")."\")")
        "endif
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
    call setline(1,"#! $PATH/python")
    call setline(2,'"""test function"""')
    call setline(3,"")
    call setline(4,"import sys")
    call setline(5,"import ")
    call setline(6,"")
    call setline(7,"sys.path.append('..')")
    call setline(8,"")
    call setline(9,"class TestClass:")
    call setline(10,'    """test class"""')
    call setline(11,"    def setup(self):")
    call setline(12,'        """test setup"""')
    call setline(13,"        pass")
    call setline(14,"    def tearDown(self):")
    call setline(15,'        """test tearDown"""')
    call setline(16,"        pass")
    call setline(17,"    def test_c1(self):")
    call setline(18,'        """test class"""')
    call setline(19,"        pass")
    call setline(20,"")
endfunc

noremap <C-e>init :call <SID>dyPyInit()<cr>
noremap <C-e>test :call <SID>createUnitTest()<cr>
noremap <SPACE> o""" """<Esc>

