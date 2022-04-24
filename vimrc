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
"Plugin 'gu-fan/riv.vim'
"Plugin 'gu-fan/rhythm.css'
"Plugin 'gu-fan/InstantRst'
Plugin 'majutsushi/tagbar'
Plugin 'rkulla/pydiction'
"Plugin 'mathjax/MathJax'
"Plugin 'vimwiki/vimwiki'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'mattn/emmet-vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'Rykka/riv.vim'
Plugin 'Rykka/rhythm.css'
Plugin 'Rykka/InstantRst'

call vundle#end()            " required
"call vundle#config#require(g:bundles)
filetype plugin indent on

"source $VIMRUNTIME/vimrc_example.vim
if has('win32')
    "source $VIMRUNTIME/mswin.vim
    " backspace and cursor keys wrap to previous/next line
    " set mouse=nv
    set guioptions+=a
    set clipboard=autoselect
    set backspace=indent,eol,start whichwrap+=<,>,[,]
    au GUIEnter * simalt ~x
    set encoding=utf-8
    set langmenu=zh_CN.UTF-8
    "set guifont=Consolas:h14
    "set guifont=DejaVu_Sans_Mono:h14
    "set guifont=仿宋:h14
    "set guifont=SimHei:h14
    "set guifont=SimSun:h14
    set guifont=NSimSun:h14
    "language message zh_CN.UTF-8
    "处理菜单及右键菜单乱码
    "source $VIMRUNTIME/delmenu.vim
    "source $VIMRUNTIME/menu.vim
    "unmap <C-V>
    "cunmap <C-V>
    "unmap <C-Y>
    "iunmap <C-Y>
"    " tags
    "colorscheme pablo
    colorscheme desert
    let g:tagbar_ctags_bin = '$HOME/vimfiles/ctags58/ctags.exe'
    let g:pydiction_location = '$HOME/vimfiles/bundle/pydiction/complete-dict'
elseif has('unix')
    let g:tagbar_ctags_bin = '/usr/bin/ctags'
    let g:pydiction_location = '$HOME/.vim/bundle/pydiction/complete-dict'
    noremap <C-h> :VimwikiGoBackLink<cr>
    set laststatus=2
    set statusline=
    set statusline+=\ %f
    set statusline+=%m
    set statusline+=%=
    set statusline+=\ %l:%c
    set statusline+=\ %p%%
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
set foldmethod=indent
set foldlevel=1
"set foldmethod=marker
"set foldnestmax=5
"set foldignore="~"
set fileformat=unix


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
"set mouse=a " 打开鼠标模式
"set mouse=v " 鼠标选择
"set autochdir
"set colorscheme 

" language set ******************
" 设置编码
"if has("win32")
"set fileencoding=chinese
"set encoding=utf-8
"let &termencoding=&encoding
"set fileencodings=utf-8,gbk,ucs-bom,cp936
"else
set fileencoding=utf-8
"endif
" 设置文件编码检测类型及支持格式
set fileencodings=ucs-bom,utf-8,cp936,gb18030,gb2312,gbk
" F2 开关行号; F3 改变目录到当前文件所在目录
nnoremap <F2> :set nonumber!<CR>:set foldcolumn=0<CR> 
nnoremap <F3> :cd %:h<CR>
nnoremap <F4> :setlocal spell! spelllang=en_us
nnoremap <F5> :set cuc! cul!<CR>
"inoremap <F5> <br />

" global key map
iab xtime <c-r>=strftime("%T")
"iab xtime <c-r>=strftime("%c wd%w # ")
iab xday <c-r>=strftime("%Y-%m-%d")
iab xdate <c-r>=strftime("%Y_%m_%d")
iab vimhome <c-r>=$HOME<C-I>
iab cdir <c-r>=expand('%:p:h')<C-I>

"" file type set ******************
noremap <C-e>h :call AddHead()<cr>
autocmd BufRead,BufNewFile *.wsdl setf xml
autocmd BufRead,BufNewFile *.xsd setf xml
autocmd BufRead,BufNewFile *.lisa setf c
" file type set ******************

"" YCM
"  let g:ycm_confirm_extra_conf = 1
"  "let g:ycm_extra_conf_globlist = ["/home/lhy/.ycm_extra_conf.py"]
"  "let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"  "let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"  "let g:SuperTabDefaultCompletionType = '<C-n>'
"  "
"  nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
"  nnoremap <leader>ji :YcmCompleter GoToImplementation<CR>

" syntax check ******************
let g:syntastic_mode_map = {
    \ "mode": "passive",
    \ "active_filetypes": ["ruby", "php", "systemverilog"],
    \ "passive_filetypes": ["puppet"] }

    "\ "active_filetypes": ["ruby", "php", "cpp", "c", "systemverilog"],
"let g:syntastic_cpp_checkers = ["g++"]
"let g:syntastic_cpp_config_file = '.syntastic_cpp_config'
"let g:syntastic_cpp_include_dirs = ["libs", "headers"]
"let g:syntastic_cpp_no_default_include_dirs = 1
"let g:syntastic_c_checkers = ["gcc"]
"let g:syntastic_c_config_file = '.syntastic_c_config'
"let g:syntastic_c_include_dirs = ["libs", "headers"]
"let g:syntastic_c_no_default_include_dirs = 1
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" calls `:SyntasticCheck`.
" python *************
" map <F12> :!python.exe %
"map :!'$path/python.exe' %

" ******** plugin setting ********
" ** tagbar set 
"let g:tagbar_left = 1
" ** snipMate
    "imap <C-J> <Plug>snipMateNextOrTrigger
    "smap <C-J> <Plug>snipMateNextOrTrigger
    let g:snipMate = { 'snippet_version' : 1 }
" ** vimwiki set -- RIV ******************
    let proj1 = { 'name': 'work', 'path': '~/wiki/work',}
    let proj2 = { 'name': 'note', 'path': "~/wiki/note" }
    let proj3 = { 'name': 'tech', 'path': "~/wiki/tech" }
    let proj4 = { 'name': 'project', 'path': "~/wiki/project"}
    let g:riv_auto_format_table = 0
    let g:riv_force = 1
    set mmp=2000
"
 
"matchit
packadd! matchit
let b:match_words = '\<if\>:\<endif\>:\<else\>,'
    \ . '\<while\>:\<continue\>,'
    \ . '\<begin\>:\<end\>,'
    \ . '\<module\>:\<endmodule\>,'
    \ . '\<class\>:\<endclass\>,'
    \ . '\<program\>:\<endprogram\>,'
    \ . '\<clocking\>:\<endclocking\>,'
    \ . '\<property\>:\<endproperty\>,'
    \ . '\<sequence\>:\<endsequence\>,'
    \ . '\<package\>:\<endpackage\>,'
    \ . '\<covergroup\>:\<endgroup\>,'
    \ . '\<primitive\>:\<endprimitive\>,'
    \ . '\<specify\>:\<endspecify\>,'
    \ . '\<generate\>:\<endgenerate\>,'
    \ . '\<interface\>:\<endinterface\>,'
    \ . '\<function\>:\<endfunction\>,'
    \ . '\<task\>:\<endtask\>,'
    \ . '\<case\>\|\<casex\>\|\<casez\>:\<endcase\>,'
    \ . '\<fork\>:\<join\>\|\<join_any\>\|\<join_none\>,'
    \ . '`ifdef\>:`else\>:`endif\>,'
    \ . '\<generate\>:\<endgenerate\>'

if $OS =~ "Windows.*"
    source ~/vimfiles/local.vim
else
    source ~/.vim/local.vim
endif
