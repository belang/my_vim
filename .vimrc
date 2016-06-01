
set nocompatible
filetype off 

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/DrawIt'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'vimwiki/vimwiki'
Plugin 'mathjax/MathJax'
Plugin 'mattn/emmet-vim'
"Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
"call vundle#config#require(g:bundles)
filetype plugin indent on

source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

autocmd BufNewFile,BufRead *.py exec "source ~/my_vim/py_vimset.vim"
autocmd BufNewFile *.py exec ".call w:PySetMain()"
autocmd BufNewFile *.html exec ".call w:HtmlHead()"
"\ set fileformat=unix

"set encoding=utf-8
"let &termencoding=&encoding
"set fileencodings=utf-8,gbk,ucs-bom,cp936

"""""""""""""""""""""""""""""""user set
" basic set ******************
set nobackup		" do not keep a backup file, use versions instead
" F2 开关行号
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR> 
"set mouse=a " 打开鼠标模式
"set mouse=v " 鼠标选择
"autocmd BufRead *.py exec "set foldmethod=indent"
set autochdir
"set colorscheme 
"colorscheme pablo
colorscheme torte
"set fileencodings=GBK,UTF-8,gb18030,ucs-bom,cp936
"set viminfo='50,n$VIMRUNTIME\_viminfo

"set foldmethod=marker
set foldnestmax=3
set foldignore=~
" language set ******************
" 设置编码
"if has("win32")
"set fileencoding=chinese
"else
"set fileencoding=utf-8
"endif
set fileencoding=utf-8

"解决consle输出乱码
"language messages zh_CN.utf-8 竟然用不上！！

" 设置文件编码检测类型及支持格式
"set fileencodings=utf-8,chinese,latin-1
set fencs=utf-8,gbk,ucs-bom,gb18030,gb2312,cp936
" 指定菜单语言
"set langmenu=zh_CN.utf-8
"set langmenu=en_us.utf-8
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim
"set guifont=DejaVu\ Sans\ Mono:h10
"set guifont=\ 22
"set guifontwide=:h4
"set guifontwide=黑体:h10
"set guifontwide=仿宋:h14
"set guifont=微软雅黑:h10
"set guifontwide=微软雅黑:h4
"set guifontwide=新宋体:h14
"set guifontwide=幼圆:h14

"帮助语言
"set helplang=cn
set helplang=en
set iskeyword+=
"au BufNewFile,BufRead *.wiki set spell spelllang=en_us
" maxize window
"if has('win32')
"    au GUIEnter * simalt ~x
"else
"    au GUIEnter * call MaximizeWindow()
"endif
" 
"function! MaximizeWindow()
"    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
"endfunction

" verilog set ******************
autocmd BufRead *.v exec "source $HOME/my_vim/myfunc_verilog.vim"
autocmd BufNewFile *.v exec "call YSetTitle()"
" verilog set ******************

" vimwiki set ******************
let g:vimwiki_list = [{'path': '~/work_wiki/', 
    \ 'path_html': '~/public_html/',
    \ 'template_path': '~/template/',
    \ 'template_default': 'template',
    \ 'template_ext': '.html'}]

inoremap <F5> <br />
" vimwiki set ******************
"
" global key map
iab xdate <c-r>=strftime("%c wd%w # ")<C-I>
iab vimhome <c-r>=$HOME<C-I>
iab cdir <c-r>=pwd<C-I>

" tagexplore
" let TE_Ctags_Path = 'd:\lianghy\.vim\ctags58\ctags.exe'

" tags
" set tags=~/tags
"Tlist_Ctags_Cmd = 'e:\\work\\.vim\\ctags58\\ctags.exe'
let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Inc_Winwidth = 0
let g:tagbar_ctags_bin = '/usr/bin/ctags'

"let python = 'd:/Python34/python.exe'
" python *************
map <F12> :!python.exe %
noremap <SPACE> o""" """<Esc>
"map :!'d:/Python34/python.exe' %

" eclim python set ******************
nnoremap <silent> <buffer> <cr> :PythonSearchContext<cr>
" tagbar set ******************
"let g:tagbar_left = 1
"
" user funtion ******************
  func w:HtmlHead()
    if &filetype == 'html'
      call setline(1,"<!DOCTYPE html>")
      call setline(2,"<html>")
      call setline(3,"	<head>")
      call setline(4,"	<title></title>")
      call setline(5,"	</head>")
      call setline(6,"	<body>")
      call setline(7,"	</body>")
      call setline(8,"</html>")
    endif
  endfunc
