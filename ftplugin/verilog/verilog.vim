if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1  " Don't load another plugin for this buffer
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set expandtab 
set autoindent 

" always
"nnoremap <C-E>anl :call Always(0, 0)<cr>

" import
vnoremap <C-E>imp :s/ *\(\%(i_\)\\|\%(o_\)\)\?\([^,]*\)\(,\?\)/    .\1\2    (\2)\3/<cr>
nnoremap <buffer> <C-E>apl :call verilog#dyAddPinList()<Enter>
nmap ; A;<Esc>
vmap ; :s/$/;/<cr>/asdf<cr>
nmap , g$x
nnoremap <buffer> <C-E>ins :call verilog#dyGenInstance()<Enter>

" add pins to module define
"
"

func! verilog#dyGenInstance()
    let start_line = line(".")+1
    let end_line = 100000
    let line_num = start_line
    let pin_length = 0
    let pin_list = []
    let new_str = []
    while line_num < end_line
        let line_str = getline(line_num)
        if line_str =~ '^);'
            let end_line = line_num
            break
        else
            let pin_length = max([strwidth(line_str), pin_length])
            let line_num = line_num+1
        endif
    endwhile
    let line_num = start_line
    while line_num < end_line
        let line_str = getline(line_num)
        let cur_pin_len = strwidth(line_str)
        let space = repeat(" ", pin_length-cur_pin_len)
        let re_str = '    .\1\2' . space . '    (\2)\3'
        let repl = substitute(line_str, ' *\(\%(i_\)\\|\%(o_\)\)\?\([^,]*\)\(,\?\)', re_str, 'g')
        call setline(line_num, repl)
        let line_num = line_num+1
    endwhile
endfunction

func! verilog#dyAddPinList()
    let total_lines = line("$")
    let line_num = 0
    let module_head_line_num = 1000000
    let pin_list = []
    "search module defination
    while line_num <= total_lines
        let line_str = getline(line_num)
        if line_str =~ '^module.*'
            let module_head_line_num = line_num
            let line_num = line_num +1
            break
        endif
        let line_num = line_num +1
    endwhile
    if module_head_line_num == 1000000
        exit
    endif
    "remove origin pin list
    let cur_pos = line_num
    while line_num <= total_lines
        let line_str = getline(cur_pos)
        if line_str =~ '^);.*'
            break
        endif
        execute(':'.cur_pos.'d')
        let line_num = line_num +1
    endwhile
    let total_lines = line("$")
    let line_num = 0
    while line_num <= total_lines
        let line_str = getline(line_num)
        if line_str =~ '^ *input .*'
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
        elseif line_str =~ '^ *inout .*'
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
    let line_num = 0
    let total_lines = line("$")
    if len(pin_list) > 0
        "add pin list
        while line_num <= total_lines
            let line_str = getline(line_num)
            if line_str =~ '^module.*'
                break
            endif
            let line_num = line_num + 1
        endwhile
    endif
    for pin in pin_list
        let pin_line = "    " . pin . ','
        call append(line_num, pin_line)
        let line_num = line_num + 1
    endfor
    let line_str = getline(line_num)
    call setline(line_num, line_str[0:-2])
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
        call setline(9 ,");")
        call setline(10,"")
        call setline(11,"input  clk, rst_n;")
        call setline(12,"endmodule")
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
