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
nnoremap <buffer> <C-E>apl :call systemverilog#dyAddPinList()<Enter>
nmap ; A;<Esc>
vmap ; :s/$/;/<cr>/asdf<cr>
nmap , g$x
nnoremap <buffer> <C-E>ins :call systemverilog#dyGenInstance()<Enter>
nnoremap <buffer> <C-E>block :call systemverilog#dyAddBlockTitle()<Enter>
nnoremap <buffer> <C-E>declare :call systemverilog#dyDeclare()<Enter>

" add pins to module define
"
"

func! systemverilog#dyGenInstance()
    let start_line = line(".")+1
    let end_line = 100000
    let line_num = start_line
    let pin_length = 0
    let pin_list = []
    let new_str = []
    while line_num < end_line
        let line_str = getline(line_num)
        if line_str =~ '^ *);'
            let end_line = line_num
            break
        else
            if line_str =~ "^ *//"
                let line_num = line_num+1
                continue
            else
                " remove spaces and defines of ports, comman after ports
                " let line_str = substitute(line_str, '^.* \([^,\S]\+\),\? *', '\1', '')
        let line_str = substitute(line_str, '^ *', '', '')                    " remove front space
        let line_str = substitute(line_str, ',.*', '', '')                    " remove comma
        let line_str = substitute(line_str, '//.*', '', '')                   " remove comment
        let line_str = substitute(line_str, '.* \(\S\+\)$', '\1', '')         " remove non last string
                let pin_length = max([strwidth(line_str), pin_length])
            endif
            let line_num = line_num+1
        endif
    endwhile
    "call append(start_line, '    .*,')
    let line_num = start_line
    while line_num < end_line
        let line_str = getline(line_num)
        if line_str =~ "^ *$"
            let line_num = line_num+1
            continue
        endif
        if line_str =~ "^ *//"
            let line_num = line_num+1
            continue
        endif
        " remove spaces and defines of ports, comman after ports
        let line_str = substitute(line_str, '^ *', '', '')                    " remove front space
        let line_str = substitute(line_str, ',.*', '', '')                    " remove comma
        let line_str = substitute(line_str, '//.*', '', '')                   " remove comment
        let line_str = substitute(line_str, '.* \(\S\+\) *$', '\1', '')       " remove non last string
        let cur_pin_len = strwidth(line_str)
        let space = repeat(" ", pin_length-cur_pin_len)
        let re_str = '    .\1\2' . space . '    (\2),'
        "let repl = substitute(line_str, ' *\(\%(in_\)|\%(out_\)\)\?\([^,]*\)\(,\?\)', re_str, 'g')
        let line_str = substitute(line_str, '^\(i_\|o_\)\?\(.*\)', re_str, 'g')
        let re_str_io = '    .\1\2' . space . '    (wi_\2),'
        let line_str = substitute(line_str, '^io_\(.*\)', re_str_io, 'g')
        call setline(line_num, line_str)
        let line_num = line_num+1
    endwhile
    " remove last line comma
    let line_num = line_num-1
    let line_str = getline(line_num)
    let repl = substitute(line_str, '\(.*\),', '\1', 'g')
    call setline(line_num, repl)
endfunction

" add pin list
"
" sub func

func! systemverilog#CatchOneLine(line_str, pin_list)
    "" the string after ] and before // are pins. 
    let sub_str = substitute(a:line_str, ';', '', 'g')
    if sub_str =~ '.*[.*'
        let sub_str_list = split(sub_str, ']')
        let pin_str_list = split(sub_str_list[1], ' \+')
    else
        let sub_str_list = split(sub_str, ' \+')
        let pin_str_list = sub_str_list[1:-1]
    endif
    for one_pin in pin_str_list
        if one_pin =~ '//.*'
            break
        endif
        let one_pin = substitute(one_pin, ',', '', 'g')
        call add(a:pin_list, one_pin)
    endfor
endfunction

func! systemverilog#dyAddPinList()
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
            call systemverilog#CatchOneLine(line_str, pin_list)
        elseif line_str =~ '^ *output .*'
            call systemverilog#CatchOneLine(line_str, pin_list)
        elseif line_str =~ '^ *inout .*'
            call systemverilog#CatchOneLine(line_str, pin_list)
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


" systemverilog header:
func! YSetTitle()
    if &filetype == 'systemverilog'
        let fname = "".expand("%")
        let fname_short = substitute(fname, '\(.*\)\.sv', '\1', 'g')
        let line = 1
        "call setline(line,"`timescale 1ns/1ps")
        "let line = line + 1
        "call setline(line,"// file name: ".expand("%"))
        "let line = line + 1
        call setline(line,"// author: lianghy")
        let line = line + 1
        call setline(line,"// time: ".strftime("%c"))
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"module " . fname_short)
        let line = line + 1
        call setline(line,"    (")
        let line = line + 1
        call setline(line,"    input wire  clk,")
        let line = line + 1
        call setline(line,"    input logic rst_n,")
        let line = line + 1
        call setline(line,"    );")
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        call setline(line,"// resource")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        "call setline(line,"// wire")
        "let line = line + 1
        "call setline(line,"// process: main")
        "let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"endmodule")
      endif
endfunc

func! systemverilog#dyAddBlockTitle()
    call append('.', "//====================")
    call append('.', "//block: ")
    call append('.', "//====================")
endfunc

func! systemverilog#dyDeclare()
    let start_line = line(".")
    let end_line = 100000
    let line_num = start_line
    let pin_length = 0
    let pin_list = []
    let new_str = []
    while line_num < end_line
        let line_str = getline(line_num)
        if line_str =~ '^wire'
            call cursor(line_num, 0)
            execute(':m '.start_line)
        elseif line_str =~ '^reg'
            call cursor(line_num, 0)
            execute(':m '.start_line)
        endif
        let line_num = line_num+1
    endwhile
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