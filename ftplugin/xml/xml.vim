" This file contains both xml and WSDL file setting.
" Set the WSDL as xml type.
"

set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set expandtab 

func! s:YSetTitle()
  "call setline(1,"`timescale 1ns/1ps")
  "call setline(2,"// file name: .expand(%))
  "call setline(3,"// author: lianghy")
  "call setline(4,"// time: ".strftime("%c"))
  "call setline(5,"")
  call setline(1,"<?xml version=\"1.0\"?>")
  call setline(2,"<config>")
  call setline(3,"</config>")
endfunc

func! AddHead()
    call s:YSetTitle()
endfunc

" ********  WSDL *********
" 1 自动生成WSDL文件基本格式
" 2 帮助完成WSDL文件。

" generate an example wsdl file
function! NewWSDL()
    let fa = readfile($HOME."/my_vim/ftplugin/wsdl/template_w1.wsdl")
    call append(0,fa)
endfunction
