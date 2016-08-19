
set nocompatible
filetype off 

" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim/
call vundle#begin('e:/lianghy/vimfiles/bundle')
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/syntastic'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/DrawIt'
Plugin 'scrooloose/nerdtree'
Plugin 'vimwiki/vimwiki'
Plugin 'mathjax/MathJax'
Plugin 'mattn/emmet-vim'
"Plugin 'Rykka/riv.vim'
"Plugin 'Rykka/rhythm.css'
"Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
"call vundle#config#require(g:bundles)
filetype plugin indent on

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set expandtab 

" filetype set ******************
autocmd BufNewFile,BufRead *.py exec "source $HOME/my_vim/py_vimset.vim"
autocmd BufNewFile *.py exec ".call w:PySetMain()"
autocmd BufNewFile *.html exec ".call w:HtmlHead()"
autocmd BufRead *.v exec "source $HOME/my_vim/myfunc_verilog.vim"
autocmd BufNewFile *.v exec ".call YSetTitle()"
"autocmd BufRead,BufNewFile *.wsdl		setfiletype xml
autocmd BufNewFile *.wsdl exec "source $HOME/my_vim/ftplugin/wsdl/dywsdl.vim"		

" basic set ******************
set nobackup		" do not keep a backup file, use versions instead
" F2 开关行号
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR> 
set autochdir
colorscheme torte

" language set ******************
" 设置编码
"if has("win32")
"set fileencoding=chinese
"else
"set fileencoding=utf-8
"endif
set encoding=utf-8
let &termencoding=&encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936
set fileencoding=utf-8
"解决consle输出乱码
language messages zh_CN.utf-8
" 设置文件编码检测类型及支持格式
set fencs=utf-8,gbk,ucs-bom,gb18030,gb2312,cp936
" 指定菜单语言
set langmenu=zh_CN.utf-8
"set langmenu=en_us.utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set guifont=DejaVu\ Sans\ Mono:h12
"set guifontwide=:h10
"set guifontwide=黑体:h10
"set guifontwide=仿宋:h14
"set guifont=微软雅黑:h14
"帮助语言
"set helplang=cn
set helplang=en
set iskeyword+=

set fileformat=unix

" maxize window
if has('win32')
    au GUIEnter * simalt ~x
else
    au GUIEnter * call MaximizeWindow()
endif
 
function! MaximizeWindow()
    silent !wmctrl -r :ACTIVE: -b add,maximized_vert,maximized_horz
endfunction


let g:vimwiki_list = [{'path': '~/work_wiki/', 
    \ 'path_html': '~/public_html/',
    \ 'template_path': '~/template/',
    \ 'template_default': 'template',
    \ 'template_ext': '.html'}]


" rst:riv.vim set ******************
"let proj1 = { 'path': '~/360yunpan/rst',}
"let g:riv_projects = [proj1]
"let g:riv_temp_path = 0
"set directory="~/vimdata/temp"

" key map
inoremap <F5> <br />
iab xdate <c-r>=strftime("%c wd%w # ")<C-I>
iab vimhome <c-r>=$HOME<C-I>
iab cdir <c-r>=pwd<C-I>

" tagexplore
" let TE_Ctags_Path = 'd:\lianghy\vimfiles\ctags58\ctags.exe'

" tags
" set tags=~/tags
"Tlist_Ctags_Cmd = 'e:\\work\\vimfiles\\ctags58\\ctags.exe'
let Tlist_Ctags_Cmd = '$HOME/vimfiles/ctags58/ctags.exe'
let Tlist_Inc_Winwidth = 0
let g:tagbar_ctags_bin = '$HOME/vimfiles/ctags58/ctags.exe'

"let python = 'd:/Python34/python.exe'
" python *************
map <F12> :!python.exe %
noremap <SPACE> o""" """<Esc>
"map :!'d:/Python34/python.exe' %
" user funtion ******************
