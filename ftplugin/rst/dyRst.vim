"
" 说明
" 为了便于完成reStructureText格式文件，本文提供了一些快捷方式。
" C-E是调用函数的前缀。
" sh* : 章节标题*
" tb+ : 在表格当前行的上一行增加一行+--+结构。

nnoremap <C-E>sh1 :call dyRst#dyAddSectionHead(1)<Enter>
nnoremap <C-E>sh2 :call dyRst#dyAddSectionHead(2)<Enter>
nnoremap <C-E>sh3 :call dyRst#dyAddSectionHead(3)<Enter>

nnoremap <buffer> <C-E>tbh :call dyRst#dyAddTblPluse()<Enter>
nnoremap <buffer> <CR> :call dyRst#dyGoToRstFile()<Enter>
" {{{1 Create/Modify Title
"fun! s:is_title(str) "{{{
"    return a:str =~ '\S' && a:str !~ g:_riv_p.section
"endfun "}}}
"fun! s:is_sline(str) "{{{
"    return a:str =~ g:_riv_p.section
"endfun "}}}
"
"******** global config
let g:dyRst_hn = ['','=','-','~','*','#']

"******** pub func
fun! s:is_blank(str) "{{{
    return a:str =~ '^\s*$'
endfun "}}}

function! s:strdiswidth(cell_str)
    return strdisplaywidth(a:cell_str)
endfunction

"******** main func

function! dyRst#dyAddSectionHead(level,...) "{{{
	let head_row = line('.')
	let head_name = getline(head_row)
	if s:is_blank(head_name)
		echo 'empty head name'
	else
		let punc = g:dyRst_hn[a:level]
		let sline = repeat(punc, strdisplaywidth(head_name))
		call append(head_row,sline)
	endif
endfunction "}}}

function! dyRst#dyAddTblPluse() "{{{
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

function! dyRst#dyGoToRstFile() "{{{
    " get line string
    " add rst
    " go to 
    let lstring = getline(line('.'))
    let fname = getTextOfCursor(lstring)
endfunction "}}}
