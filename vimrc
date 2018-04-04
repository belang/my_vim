
set nocompatible
filetype off 

"if has('win32')
if $OS =~ "Windows.*"
	set rtp+=~/vimfiles/bundle/Vundle.vim
	call vundle#begin('~/vimfiles/bundle')
"elseif has('unix')
elseif $OS =~ "Unix"
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
else
	set rtp+=~/.vim/bundle/Vundle.vim
	call vundle#begin()
endif

" set the runtime path to include Vundle and initialize
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'godlygeek/tabular'
Plugin 'othree/xml.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
"Plugin 'tomtom/tlib_vim'
Plugin 'vim-scripts/tlib'
"Plugin 'SirVer/ultisnips'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'vim-scripts/VisIncr'
Plugin 'vim-scripts/DrawIt'
Plugin 'Rykka/riv.vim'
Plugin 'Rykka/rhythm.css'
Plugin 'Rykka/InstantRst'
Plugin 'majutsushi/tagbar'
Plugin 'rkulla/pydiction'
"Plugin 'mathjax/MathJax'
"Plugin 'vimwiki/vimwiki'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'mattn/emmet-vim'
"Plugin 'Valloric/YouCompleteMe'

call vundle#end()            " required
"call vundle#config#require(g:bundles)
filetype plugin indent on

"source $VIMRUNTIME/vimrc_example.vim
if has('win32')
    "source $VIMRUNTIME/mswin.vim
    " backspace and cursor keys wrap to previous/next line
    set backspace=indent,eol,start whichwrap+=<,>,[,]
    au GUIEnter * simalt ~x
    set fileformat=unix
    set encoding=utf-8
    set langmenu=zh_CN.UTF-8
    "set guifont=Consolas:h14
    set guifont=DejaVu_Sans_Mono:h14
    language message zh_CN.UTF-8
    "处理菜单及右键菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    "unmap <C-V>
    "cunmap <C-V>
    "unmap <C-Y>
    "iunmap <C-Y>
"    " tags
    let g:tagbar_ctags_bin = '$HOME/vimfiles/ctags58/ctags.exe'
    let g:pydiction_location = '$HOME/vimfiles/bundle/pydiction/complete-dict'
elseif has('unix')
    "set fileformat=unix
    let g:tagbar_ctags_bin = '/usr/bin/ctags'
    let g:pydiction_location = '$HOME/.vim/bundle/pydiction/complete-dict'
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

set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
"set textwidth=79 
set expandtab 
set autoindent 
set formatoptions+=m
"set foldmethod=marker
"set foldnestmax=5
"set foldignore="~"

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
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,gbk

" vimwiki set -- RIV ******************
let proj1 = { 'path': '~/my_wiki'}
let proj2 = { 'path': '~/project'}
let g:riv_projects = [proj1, proj2]
"let g:riv_auto_format_table = 0

inoremap <F5> <br />
" vimwiki set ******************
"
" global key map
iab xdate <c-r>=strftime("%c wd%w # ")
iab xday <c-r>=strftime("%Y-%m-%d")
iab vimhome <c-r>=$HOME<C-I>
iab cdir <c-r>=expand('%:p:h')<C-I>

"" file type set ******************
noremap <C-e>h :call AddHead()<cr>
autocmd BufRead,BufNewFile *.wsdl setf xml
autocmd BufRead,BufNewFile *.xsd setf xml
autocmd BufRead,BufNewFile *.rst setf rst
" file type set ******************


"let python = 'd:/Python34/python.exe'
" python *************
" map <F12> :!python.exe %
"map :!'d:/Python34/python.exe' %

" eclim python set ******************
"nnoremap <silent> <buffer> <cr> :PythonSearchContext<cr>
" tagbar set ******************
"let g:tagbar_left = 1
"
