"
" 说明
" 为了便于完成reStructureText格式文件，本文提供了一些快捷方式。
"

" {{{1 Create/Modify Title
"fun! s:is_title(str) "{{{
"    return a:str =~ '\S' && a:str !~ g:_riv_p.section
"endfun "}}}
"fun! s:is_sline(str) "{{{
"    return a:str =~ g:_riv_p.section
"endfun "}}}
fun! s:is_blank(str) "{{{
    return a:str =~ '^\s*$'
endfun "}}}

let g:dyRst_hn = ['','=','-','~','*','#']

inoremap <C-E>zt1 <Esc>:call dyRst#dyAddSectionHead(1)<Enter>
nnoremap <C-E>zt1 :call dyRst#dyAddSectionHead(1)<Enter>

function! dyRst#dyAddSectionHead(level,...)
	let head_row = line('.')-1
	let head_name = getline(head_row)
	if s:is_blank(head_name)
		echo 'empty head name'
	else
		let punc = g:dyRst_hn[a:level]
		let sline = repeat(punc, strdisplaywidth(head_name))
		call append(head_row,sline)
	endif
endfunction
