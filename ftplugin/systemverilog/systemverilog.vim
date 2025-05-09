if exists("b:did_msv_ftplugin")
  finish
endif
let b:did_msv_ftplugin = 1  " Don't load another plugin for this buffer
let b:intentwidth = "  "
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set foldlevel=0
set textwidth=100
"set guifont=Fira_Code:h14
let g:gruvbox_italic=0
let g:gruvbox_italicize_comments=0

""verilog syntax
":compiler vcs
"let &makeprg='vlogan +v2k -full64 +vcs+flush+all +lint=all -sverilog +libext+.v+.sv -lca %'
"autocmd BufWritePost *.v exec ":make"
"
":compiler verilator
"let &makeprg='verilator -Wall --sc --exe'
"autocmd BufWritePost *.sv exec ":make"

let g:ale_linters = {'systemverilog' : ['verilator'],}
let g:ale_systemverilog_verilator_executable = 'verilator'
let g:ale_systemverilog_verilator_options = '-Wall -I. -I./util'

" always
"nnoremap <C-E>anl :call Always(0, 0)<cr>

" import
vnoremap <C-E>imp :s/ *\(\%(i_\)\\|\%(o_\)\)\?\([^,]*\)\(,\?\)/    .\1\2    (\2)\3/<cr>
nnoremap <buffer> <C-E>apl :call systemverilog#dyAddPinList()<Enter>
nmap ; A;<Esc>
vmap ; :s/$/;/<cr>/asdf<cr>
nmap , g$x
nnoremap <buffer> <C-E>ins :call systemverilog#dyGenInstance()<Enter>
nnoremap <buffer> <C-E>bl :call systemverilog#dyAddBlockTitle()<Enter>
nnoremap <buffer> <C-E>dec :call systemverilog#dyDeclare()<Enter>

" add pins to module define
"
"

func! systemverilog#dyGenInstance()
    let name_line = line(".")
    let insn_name = substitute(getline(name_line), '^ *\S\+ \+u_\(\S\+\) *(', '\1', '')
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
        let line_str = substitute(line_str, ' *//.*', '', '')                 " remove comment
        let line_str = substitute(line_str, ',.*', '', '')                    " remove comma
        let line_str = substitute(line_str, '.* \(\S\+\) *$', '\1', '')       " remove non last string
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
        let line_str = substitute(line_str, ' *//.*', '', '')                 " remove comment
        let line_str = substitute(line_str, ',.*', '', '')                    " remove comma
        let line_str = substitute(line_str, '.* \(\S\+\) *$', '\1', '')       " remove non last string
        let cur_pin_len = strwidth(line_str)
        let space = repeat(" ", pin_length-cur_pin_len)
        "let re_str = '    .\1\2' . space . '    (\2),'
        "let repl = substitute(line_str, ' *\(\%(in_\)|\%(out_\)\)\?\([^,]*\)\(,\?\)', re_str, 'g')
        "let line_str = substitute(line_str, '^\(i_\|o_\)\?\(.*\)', re_str, 'g')
        "if line_str =~ "^.*_io$"
        if line_str =~ "^io_.*$"
            let re_str = b:intentwidth . '.\1\2' . space . '    (bi_\2),'
            let line_str = substitute(line_str, '^\(io_\)\(.*\)', re_str, 'g')
            "let line_str = substitute(line_str, '^\(.*\)\(_io\)', re_str, 'g')
        else
            "if line_str =~ "^.*_i$"
            if line_str =~ "^i_.*$"
                "let re_str = '    .\1\2' . space . '    (to_\2),'
                let re_str = b:intentwidth . '.\1\2' . space . '    (to_' . insn_name . '_\2),'
                let line_str = substitute(line_str, '^\(i_\)\(.*\)', re_str, 'g')
                "let line_str = substitute(line_str, '^\(.*\)\(_i\)', re_str, 'g')
            else
                "if line_str =~ "^.*_o$"
                if line_str =~ "^o_.*$"
                    "let re_str = '    .\1\2' . space . '    (fr_\2),'
                    let re_str = b:intentwidth . '.\1\2' . space . '    (fr_' . insn_name . '_\2),'
                    let line_str = substitute(line_str, '^\(o_\)\(.*\)', re_str, 'g')
                    "let line_str = substitute(line_str, '^\(.*\)\(_o\)', re_str, 'g')
                else
                    let re_str = b:intentwidth . '.\1' . space . '    (\1),'
                    let line_str = substitute(line_str, '\(.*\)', re_str, 'g')
                endif
            endif
        endif
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
        let indent = "  "
        "let module_name = substitute(fname_short, '.*\([^_]\+\)', '\1', 'g')
        let line = 1
        "call setline(line,"`timescale 1ns/1ps")
        "let line = line + 1
        "call setline(line,"// file name: ".expand("%"))
        "let line = line + 1
        "call setline(line, "// Copyright my contributors.")
        "let line = line + 1
        "call setline(line, "// Licensed under the Apache License, Version 2.0, see LICENSE for details.")
        "let line = line + 1
        "call setline(line, "// SPDX-License-Identifier: Apache-2.0")
        "let line = line + 1
        call setline(line, "// See README for Copyright")
        let line = line + 1
        "call setline(line,"// Author: Hayes")
        "let line = line + 1
        "call setline(line,"// Time: ".strftime("%c"))
        "let line = line + 1
        call setline(line, "// One_line_description_of_the_module")
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"module " . fname_short)
        "call setline(line,"module " . fname_short . " (")
        let line = line + 1
        call setline(line, indent . "import " . g:my_pkg . "::*;")
        let line = line + 1
        call setline(line,"    (")
        let line = line + 1
        call setline(line, indent . "input wire  clk,")
        let line = line + 1
        call setline(line, indent . "input logic rst_n,")
        let line = line + 1
        call setline(line, indent . "output  logic o_" . fname_short . "_valid")
        "let line = line + 1
        "call setline(line, indent . "input  logic i_" . module_name . "_valid,")
        "let line = line + 1
        "call setline(line, indent . "input  logic i_" . module_name . "_stall,")
        "let line = line + 1
        "call setline(line, indent . "output logic i_" . module_name . "_ready,")
        let line = line + 1
        call setline(line, indent . ");")
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        call setline(line,"// resource")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line, indent . "//==instance port net")
        let line = line + 1
        call setline(line, indent . "//==end port net")
        "call setline(line,"// wire")
        "let line = line + 1
        "call setline(line,"// process: main")
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        call setline(line,"// state")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        call setline(line,"// process")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        call setline(line,"// instance")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        call setline(line,"// translate")
        let line = line + 1
        call setline(line,"//====================")
        let line = line + 1
        call setline(line,"  // translate_off")
        let line = line + 1
        call setline(line,"  // translate_on")
        "let line = line + 1
        "call setline(line,"always_comb begin : cal_output")
        "let line = line + 1
        "call setline(line,"end : cal_output")
        let line = line + 1
        call setline(line,"")
        let line = line + 1
        call setline(line,"endmodule")
      endif
endfunc

func! systemverilog#dyAddBlockTitle()
    call append('.', b:intentwidth . "//==end block")
    call append('.', "")
    call append('.', "//====================")
    call append('.', "//block: ")
    call append('.', "//====================")
endfunc

func! systemverilog#dyDeclare()
    "let start_line = line(".")
    "let end_line = 100000
    "let line_num = start_line
    "let pin_length = 0
    "let pin_list = []
    "let new_str = []
    "while line_num < end_line
        "let line_str = getline(line_num)
        "if line_str =~ '^wire'
            "call cursor(line_num, 0)
            "execute(':m '.start_line)
        "elseif line_str =~ '^reg'
            "call cursor(line_num, 0)
            "execute(':m '.start_line)
        "endif
        "let line_num = line_num+1
    "endwhile
    "let name_line = line(".")
    "let insn_name = substitute(getline(name_line), '^\S\+ u_\(\S\+\) *(', '\1', '')
    let start_line = line(".")
    let end_line = 100000
    let pin_length = 0
    let pin_list = []
    let new_str = []
    "call append(start_line, '    .*,')
    let line_num = start_line
    while line_num < end_line
        let line_str = getline(line_num)
        if line_str =~ '^ *);'
            let end_line = line_num
            break
        endif
        let org_line_str = getline(line_num)
        if org_line_str =~ "^    //==end port net"
            break
        endif
        if org_line_str =~ '^ *\S\+ \+u_\(\S\+\) *('
            let insn_name = substitute(org_line_str, '^ *\S\+ \+u_\(\S\+\) *(', '\1', '')
            let new_str = '  // ' . insn_name
            call setline(line_num, new_str)
            let line_num = line_num+1
            continue
        endif
        if org_line_str =~ "^ *$"
            let line_num = line_num+1
            continue
        endif
        if org_line_str =~ "^ *//"
            let line_num = line_num+1
            continue
        endif
        if org_line_str =~ "^ *.* clk,.*$"
            "let line_num = line_num+1
            call cursor(line_num, line_num)
            execute(':delete')
            continue
        endif
        if org_line_str =~ "^ *.* rst_n,.*$"
            call cursor(line_num, line_num)
            execute(':delete')
            "let line_num = line_num+1
            continue
        endif
        let line_str = org_line_str
        " remove spaces and defines of ports, comman after ports
        let line_str = substitute(line_str, '^ *', '', '')                    " remove front space
        let line_str = substitute(line_str, ' *//.*', '', '')                 " remove comment
        let line_str = substitute(line_str, ',.*', '', '')                    " remove comma
        let line_str = substitute(line_str, '.* \(\S\+\) *$', '\1', '')       " remove non last string
        "let cur_pin_len = strwidth(line_str)
        "let space = repeat(" ", pin_length-cur_pin_len)
        "let re_str = '    .\1\2' . space . '    (\2),'
        "let repl = substitute(line_str, ' *\(\%(in_\)|\%(out_\)\)\?\([^,]*\)\(,\?\)', re_str, 'g')
        "let line_str = substitute(line_str, '^\(i_\|o_\)\?\(.*\)', re_str, 'g')
        "if line_str =~ "^i_.*"
        "if line_str =~ "^.*_i"
        if line_str =~ "^i_.*"
            let re_str = 'to_' . insn_name . '_\1'
            let new_name = substitute(line_str, '^i_\(.*\)', re_str, 'g')
            let new_line = substitute(org_line_str, line_str, new_name, 'g')
        else
            if line_str =~ "^o_.*"
            "if line_str =~ "^.*_o"
                let re_str = 'fr_' . insn_name . '_\1'
                let new_name = substitute(line_str, '^o_\(.*\)', re_str, 'g')
                "let new_name = substitute(line_str, '^\(.*\)_o', re_str, 'g')
                let new_line = substitute(org_line_str, line_str, new_name, 'g')
            else
                if line_str =~ "^io_.*"
                    let re_str = 'bi_\1'
                    let new_name = substitute(line_str, '^io_\(.*\)', re_str, 'g')
                    let new_line = substitute(org_line_str, line_str, new_name, 'g')
                    let re_str = '\1 \2(),'
                    let new_line = substitute(new_line, '\(IF_[^\.]\+\).[s|m|p|n] \+\([^,]*\),\?', re_str, 'g')
                else
                    let new_line = org_line_str
                endif
            endif
        endif
        let new_line = substitute(new_line, ',', ';', 'g')
        let new_line = substitute(new_line, 'input *', '', 'g')
        let new_line = substitute(new_line, 'output *', '', 'g')
        let new_line = substitute(new_line, ' *//.*', '', 'g')
        if new_line !~ ".*;"
            let new_line = substitute(new_line, '\(.*\)', '\1;', 'g')
        endif
        call setline(line_num, new_line)
        let line_num = line_num+1
    endwhile
    let new_line = '  // end ' . insn_name
    call setline(line_num, new_line)
    "let line_num = line_num-1
    "let line_str = getline(line_num)
    "let repl = substitute(line_str, '\(.*\)', '\1;', 'g')
    "call setline(line_num, repl)
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
