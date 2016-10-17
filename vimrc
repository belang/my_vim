
set nocompatible
filetype off 

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/DrawIt'
Plugin 'scrooloose/nerdtree'
Plugin 'vimwiki/vimwiki'
Plugin 'godlygeek/tabular'
Plugin 'mathjax/MathJax'
Plugin 'othree/xml.vim'
Plugin 'plasticboy/vim-markdown'
"Plugin 'scrooloose/syntastic'
"Plugin 'mattn/emmet-vim'
"Plugin 'Rykka/riv.vim'
"Plugin 'Rykka/rhythm.css'
"Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
"call vundle#config#require(g:bundles)
filetype plugin indent on

source $VIMRUNTIME/vimrc_example.vim
if has('win32')
    source $VIMRUNTIME/mswin.vim
    au GUIEnter * simalt ~x
    set fileformat=dos
    " tags
    let g:tagbar_ctags_bin = '/usr/bin/ctags'
elseif has('unix')
    set fileformat=unix
    let g:tagbar_ctags_bin = '$HOME/vimfiles/ctags58/ctags.exe'
    noremap <C-h> <Plug>VimwikiGoBackLink
    noremap <C-h> :VimwikiGoBackLink<cr>
endif

set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set expandtab 

"""""""""""""""""""""""""""""""user set
" file type set ******************
autocmd BufRead,BufNewFile *.py exec "source ~/my_vim/dyPy.vim"
autocmd BufRead,BufNewFile *.v exec "source $HOME/my_vim/dyVerilog.vim"
autocmd BufRead,BufNewFile *.rst exec "source ~/my_vim/ftplugin/rst/dyRst.vim"
noremap <C-d>h :call AddHead()<cr>
" file type set ******************

"set encoding=utf-8
"let &termencoding=&encoding
"set fileencodings=utf-8,gbk,ucs-bom,cp936

" basic set ******************
" do not keep a backup file, use versions instead
set nobackup		
" F2 开关行号
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR> 
"set mouse=a " 打开鼠标模式
"set mouse=v " 鼠标选择
set autochdir
"set colorscheme 
"colorscheme pablo
colorscheme desert
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
" 设置文件编码检测类型及支持格式
set fileencodings=utf-8,gbk,ucs-bom,gb18030,gb2312,cp936

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


"let python = 'd:/Python34/python.exe'
" python *************
map <F12> :!python.exe %
noremap <SPACE> o""" """<Esc>
"map :!'d:/Python34/python.exe' %

" eclim python set ******************
"nnoremap <silent> <buffer> <cr> :PythonSearchContext<cr>
" tagbar set ******************
"let g:tagbar_left = 1
"