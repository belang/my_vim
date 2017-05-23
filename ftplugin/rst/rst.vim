"
" 说明
" 为了便于完成reStructureText格式文件，本文提供了一些快捷方式。
" C-E是调用函数的前缀。
" sh* : 章节标题*
" tbh : 在表格当前行的上一行增加一行+--+结构。
" axl : 增加顺序号
"

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1  " Don't load another plugin for this buffer

set tabstop=4 
set softtabstop=0 
set shiftwidth=4 
set textwidth=79 
set expandtab 
set backspace=eol,start whichwrap+=<,>,[,]

nnoremap <C-E>sh1 :call rst#dyAddSectionHead(1)<Enter>
nnoremap <C-E>sh2 :call rst#dyAddSectionHead(2)<Enter>
nnoremap <C-E>sh3 :call rst#dyAddSectionHead(3)<Enter>
nnoremap <buffer> <C-E>tbh :call rst#dyAddTblPluse()<Enter>
nnoremap <buffer> <C-E>tbe :call rst#dyAddTblEqual()<Enter>
nnoremap <CR> gf

" COMMAND {{{
command! -buffer -nargs=* AddNumList call rst#dyAddNumerousList(<f-args>)
" COMMAND }}}

"nnoremap <buffer> <CR> :call rst#dyGoToRstFile()<Enter>
" {{{1 Create/Modify Title
"fun! s:is_title(str) "{{{
"    return a:str =~ '\S' && a:str !~ g:_riv_p.section
"endfun "}}}
"fun! s:is_sline(str) "{{{
"    return a:str =~ g:_riv_p.section
"endfun "}}}
"
"******** global config
let g:rst_hn = ['','=','-','~','*','#']

"******** pub func
fun! s:is_blank(str) "{{{
    return a:str =~ '^\s*$'
endfun "}}}

function! s:strdiswidth(cell_str)
    return strdisplaywidth(a:cell_str)
endfunction

"******** main func

function! rst#dyAddSectionHead(level,...) "{{{
	let head_row = line('.')
	let head_name = getline(head_row)
	if s:is_blank(head_name)
		echo 'empty head name'
	else
		let punc = g:rst_hn[a:level]
		let sline = repeat(punc, strdisplaywidth(head_name))
		call append(head_row,sline)
	endif
endfunction "}}}

function! rst#dyAddTblPluse() "{{{
    let state = 'NONE'
    let cell_length = []
    let length = 0
    let cell_str = ''
    let tar_row = line('.')-1
    let cur_row_context = getline(line('.'))
    let new_row = ''
    for idx in range(strlen(cur_row_context))
        let ch = cur_row_context[idx]
        if state ==# 'NONE'
            if ch == '|'
                let state = 'CELL'
                let length = 0
                let cell_str = ''
                continue
            endif
        elseif state ==# 'CELL'
            if ch == '|'
                let state = 'CELL'
                let length = s:strdiswidth(cell_str)
                call add(cell_length, length)
                let length = 0
                let cell_str = ''
            else
                let cell_str .= ch
            endif
        endif
    endfor
    for clen in cell_length
        let new_row .= '+'
        for plen  in range(clen)
            let new_row .= '-'
        endfor
    endfor
    let new_row .= '+'
    "echo new_row
    call append(tar_row,new_row)
endfunction "}}}

function! rst#dyAddTblEqual() "{{{
    "两个状态：EMPTY和CELL，EMPTY表示空格或初始，CELL代表字符。
    "检测到非空时，开始置CELL，将字符加入字符串，遇到空时，记算字符列表长度，加入总长度列表。
    let state = 'EMPTY'
    let cell_length = []
    let length = 0
    let cell_str = ''
    let tar_row = line('.')-1
    let cur_row_context = getline(line('.'))
    let new_row = ''
    for idx in range(strlen(cur_row_context))
        let ch = cur_row_context[idx]
        if state ==# 'EMPTY'
            if ch != ' '
                let state = 'CELL'
                let length = 0
                let cell_str .= ch
                continue
            endif
        elseif state ==# 'CELL'
            if ch == ' '
                let state = 'EMPTY'
                let length = s:strdiswidth(cell_str)
                call add(cell_length, length)
                let length = 0
                let cell_str = ''
            else
                let cell_str .= ch
            endif
        endif
    endfor
    let length = s:strdiswidth(cell_str)
    call add(cell_length, length)
    for clen in cell_length
	let cur_row_len = strlen(new_row)
	if cur_row_len != 0
            let new_row .= '  '
	endif
        for plen in range(clen)
            let new_row .= '='
        endfor
    endfor
    "echo new_row
    call append(tar_row,new_row)
endfunction "}}}

function! rst#dyAddNumerousList(length) "{{{
	let row_num = line('.')
	let row_content = getline(row_num)
	for current_line in range(a:length)
		let list_num = current_line+1
		let row_content = list_num.'. '.row_content
		call setline(row_num, row_content)
		let row_num += 1
		let row_content = getline(row_num)
	endfor
endfunction "}}}

