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

" always
"nnoremap <C-E>anl :call Always(0, 0)<cr>

" import
vnoremap <C-E>imp :s/\(\S*\),/.\1 (\1),/<cr>
nmap ; A;<Esc>
vmap ; :s/$/;/<cr>/asdf<cr>
nmap , g$x

" verilog header:
func! YSetTitle()
    if &filetype == 'verilog'
        call setline(1 ,"`timescale 1ns/1ps")
        call setline(2 ,"// file name: ".expand("%"))
        call setline(3 ,"// author: lianghy")
        call setline(4 ,"// time: ".strftime("%c"))
        call setline(5 ,"")
        call setline(6 ,"`include \"define.v\"")
        call setline(7 ,"")
        call setline(8 ,"module (")
        call setline(9 ,"    clk,")
        call setline(10,"    rst_n,")
        call setline(11,");")
        call setline(12,"input clk, rst_n;")
        call setline(13,"endmodule")
      endif
endfunc

" vim function
"

  "delfunction s:pbegin_add
  "function s:pbegin_add()
  "  execute "normal! aif () begin\rend\relse begin\rend"
  "  execute "normal! kkk"
  "endfunction
  "inoremap <buffer> if<Space>begin <Esc>:call <SID>pbegin_add()<cr>


func! AddHead()
    call YSetTitle()
endfunc
