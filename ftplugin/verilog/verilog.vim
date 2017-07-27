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
nnoremap <buffer> <C-E>apl :call verilog#dyAddPinList()<Enter>
nmap ; A;<Esc>
vmap ; :s/$/;/<cr>/asdf<cr>
nmap , g$x

" add pins to module define
"
func! verilog#dyAddPinList()
    let total_lines = line("$")
    let line_num = 0
    let module_head_line_num = 1000000
    let pin_list = []
    while line_num <= total_lines
        let line_str = getline(line_num)
        if line_str =~ '^module.*'
            let module_head_line_num = line_num
        elseif line_str =~ '^ *input .*'
            let sub_str = substitute(line_str, ';', '', 'g')
            let sub_str_list = split(sub_str, ' \+')
            for one_pin in sub_str_list[1:-1]
                if one_pin =~ '[.*'
                    continue
                endif
                let one_pin = substitute(one_pin, ',', '', 'g')
                call add(pin_list, one_pin)
            endfor
        elseif line_str =~ '^ *output .*'
            let sub_str = substitute(line_str, ';', '', 'g')
            let sub_str_list = split(sub_str, ' \+')
            for one_pin in sub_str_list[1:-1]
                if one_pin =~ '[.*'
                    continue
                endif
                let one_pin = substitute(one_pin, ',', '', 'g')
                call add(pin_list, one_pin)
            endfor
        endif
        let line_num = line_num +1
    endwhile
    if module_head_line_num == 1000000
        exit
    endif
    if len(pin_list) > 0
        let tmp_num = module_head_line_num
        for pin in pin_list
            let pin_line = "    " . pin . ','
            call append(tmp_num, pin_line)
            let tmp_num = tmp_num + 1
        endfor
    endif
endfunction


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
