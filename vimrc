
set nocompatible
filetype off 

if has('win32')
	set rtp+=~/vimfiles/bundle/Vundle.vim
	call vundle#begin('~/vimfiles/bundle/Vundle.vim')
elseif has('unix')
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin('~/.vim/bundle/Vundle.vim')
endif
" set the runtime path to include Vundle and initialize
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vimwiki/vimwiki'
Plugin 'godlygeek/tabular'
Plugin 'mathjax/MathJax'
Plugin 'othree/xml.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'garbas/vim-snipmate'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
"Plugin 'majutsushi/tagbar'
"Plugin 'vim-scripts/DrawIt'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'mattn/emmet-vim'
"Plugin 'Rykka/riv.vim'
"Plugin 'Rykka/rhythm.css'
"Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
"call vundle#config#require(g:bundles)
filetype plugin indent on

"source $VIMRUNTIME/vimrc_example.vim
if has('win32')
    source $VIMRUNTIME/mswin.vim
    au GUIEnter * simalt ~x
    set fileformat=dos
"    " tags
"    let g:tagbar_ctags_bin = '$HOME/vimfiles/ctags58/ctags.exe'
elseif has('unix')
    set fileformat=unix
"    let g:tagbar_ctags_bin = '/usr/bin/ctags'
    noremap <C-h> :VimwikiGoBackLink<cr>
endif

""""""""""""""""""""""""""""""""user set
set ruler		" show the cursor position all the time
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") >= 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

"" file type set ******************
"autocmd BufRead,BufNewFile *.py exec "source ~/my_vim/dyPy.vim"
"autocmd BufRead,BufNewFile *.v exec "source $HOME/my_vim/dyVerilog.vim"
"autocmd BufRead,BufNewFile *.rst exec "source ~/my_vim/ftplugin/rst/dyRst.vim"
noremap <C-d>h :call AddHead()<cr>
autocmd BufRead,BufNewFile *.wsdl setf xml
autocmd BufRead,BufNewFile *.xsd setf xml
autocmd BufRead,BufNewFile *.rst setf rst
" file type set ******************

" basic set ******************
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
"set viminfo='50,n$VIMRUNTIME\_viminfo

set nobackup		" do not keep a backup file, use versions instead
set undofile		" keep an undo file (undo changes after closing)
set incsearch		" do incremental searching
" F2 开关行号
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR> 
"set mouse=a " 打开鼠标模式
"set mouse=v " 鼠标选择
set autochdir
"set colorscheme 
"colorscheme pablo
colorscheme desert

"set foldmethod=marker
set foldnestmax=3
set foldignore=~
" language set ******************
" 设置编码
"if has("win32")
"set fileencoding=chinese
"set encoding=utf-8
"let &termencoding=&encoding
"set fileencodings=utf-8,gbk,ucs-bom,cp936
"else
"set fileencoding=utf-8
"endif
set fileencoding=utf-8
" 设置文件编码检测类型及支持格式
set fileencodings=utf-8,gbk,ucs-bom,gb18030,gb2312,cp936

" vimwiki set ******************
let g:vimwiki_list = [{'path': '~/work_wiki/', 
    \ 'path_html': '~/public_html/',
    \ 'template_path': '~/work_wiki/template/',
    \ 'template_default': 'template',
    \ 'template_ext': '.html'}]

inoremap <F5> <br />
" vimwiki set ******************
"
" global key map
iab xdate <c-r>=strftime("%c wd%w # ")
iab xday <c-r>=strftime("%Y-%m-%d")
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
