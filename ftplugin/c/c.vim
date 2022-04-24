if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1  " Don't load another plugin for this buffer
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

" import
nmap ; A;<Esc>
vmap ; :s/$/;/<cr>/asdf<cr>
nmap , g$x
nnoremap <buffer> <C-E>block :call c#dyAddBlockTitle()<Enter>


" c header:
func! YSetTitle()
    if &filetype == 'c'
        call setline( 1, "//  ----------------------------------------------------------------------------")
        call setline( 2, "//                    Copyright Message")
        call setline( 3, "//  ----------------------------------------------------------------------------")
        call setline( 4, "//")
        call setline( 5, "//")
        call setline( 6, "//  ----------------------------------------------------------------------------")
        call setline( 7, "//                    Design Information")
        call setline( 8, "//  ----------------------------------------------------------------------------")
        call setline( 9, "//")
        call setline(10, "//  Organisation    : ILC/ADL")
        call setline(11, "//  Date            : ".strftime("%c"))
        call setline(12, "//  Revision        : 1.0.0")
        call setline(13, "//  Description     : ")
        call setline(14, "//")
        call setline(15, "//  ----------------------------------------------------------------------------")
        call setline(16, "//                    Revision History")
        call setline(17, "//  ----------------------------------------------------------------------------")
        call setline(18, "//  ".strftime("%Y-%m-%d")."      : Lianghy")
        call setline(19, "//")
        call setline(20, "")
      endif
endfunc

func! c#dyAddBlockTitle()
    call append('.', "//====================")
    call append('.', "//block: ")
    call append('.', "//====================")
endfunc


func! AddHead()
    call YSetTitle()
endfunc
