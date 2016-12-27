func s:YSetTitle()
if &filetype == 'xml'
  "call setline(1,"`timescale 1ns/1ps")
  "call setline(2,"// file name: .expand(%))
  "call setline(3,"// author: lianghy")
  "call setline(4,"// time: ".strftime("%c"))
  "call setline(5,"")
  call setline(1,"<?xml version=\"1.0\"?>")
  call setline(2,"<config>")
  call setline(3,"</config>")
endif
endfunc

func! AddHead()
    call s:YSetTitle()
endfunc

