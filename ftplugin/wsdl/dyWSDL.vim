
" 1 自动生成WSDL文件基本格式
" 2 帮助完成WSDL文件。

function! s:newWSDL()
    call setline(1,"<?xml version=\"1.0\" encoding=\"utf-8\"?>")
    call setline(2,"")
    call setline(2,"<wsdl:definitions name=\"\"")
    call setline(2,"    targetNamespace=\"\">")
    call setline(2,"<import namespace=\"\" location=\"\">")
    call setline(2,"<next>")
    call setline(2,"<>")
    call setline(2,"<>")
    call setline(2,"<>")
    call setline(2,"<>")
    call setline(2,"<>")
    call setline(3,"# file name: ".expand("%c"))
    call setline(4,"# author: lianghy")
    call setline(5,"# time: ".strftime("%c"))
    call setline(6,"")
    call setline(7,"if __name__==\"__main__\":")
    call setline(8,"    print(\"".expand("%c")."\")") 
endfunction
