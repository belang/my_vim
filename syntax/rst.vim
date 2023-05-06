" disable vim default syntax highlighting
"let b:current_syntax = "rst"
"set spell spelllang=en_us
syn match myExCapitalWords +\<[A-Z]*\>+ contains=@NoSpell
syn match myCamelCapitalWords +\<\w\w*[A-Z]\w*\>+ contains=@NoSpell
