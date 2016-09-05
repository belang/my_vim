setfiletype xml
set autoindent
" 1 自动生成WSDL文件基本格式
" 2 帮助完成WSDL文件。

function! w:newWSDL()
    let fa = readfile("E:/lianghy/my_vim/ftplugin/wsdl/template_w1.wsdl")
    call append(0,fa)
endfunction
