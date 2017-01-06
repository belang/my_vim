
noremap <C-d>js :call jinja#AddStatements()<cr>
noremap <C-d>jc :call jinja#AddContext()<cr>

" add {% %}
func! jinja#AddStatements()
    let lnum = line('.')
    call append(lnum, '{% endblock %}')
    call append(lnum, '{% %}')
endfunc
" add {{ }}
func! jinja#AddContext()
    let lnum = line('.')
    call append(lnum, '{{ }}')
endfunc
