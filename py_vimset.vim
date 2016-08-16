set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=79 
set expandtab 
set autoindent 
set foldmethod=indent
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
    func s:PyDefFunc() abort
            return pumvisible() ? "\<c-e>" : ''
    endfunc
endif

"noremap <C-f> w:PyDefFunc()
