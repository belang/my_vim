set nocompatible
filetype off 

call plug#begin('~/.vim/bundle')

Plug 'scrooloose/nerdtree'
Plug 'godlygeek/tabular'
Plug 'othree/xml.vim'
"Plug 'scrooloose/syntastic'
Plug 'dense-analysis/ale'
Plug 'scrooloose/nerdcommenter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
Plug 'vim-scripts/tlib'
"Plug 'SirVer/ultisnips'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'vim-scripts/VisIncr'
Plug 'vim-scripts/DrawIt'
Plug 'junegunn/vim-easy-align'
"Plug 'gu-fan/riv.vim'
"Plug 'gu-fan/rhythm.css'
"Plug 'gu-fan/InstantRst'
Plug 'majutsushi/tagbar'
"Plug 'rkulla/pydiction'
"Plug 'mathjax/MathJax'
"Plug 'plasticboy/vim-markdown'
"Plug 'mattn/emmet-vim'
"Plug 'Valloric/YouCompleteMe'
Plug 'Rykka/riv.vim'
Plug 'Rykka/rhythm.css'
Plug 'Rykka/InstantRst'
"Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
Plug 'derekwyatt/vim-scala'
Plug 'lfiolhais/vim-chisel'
"Plug 'vhda/verilog_systemverilog.vim'
"Plug 'Shougo/neocomplete.vim'
Plug 'itchyny/vim-cursorword'
Plug 'vim-airline/vim-airline'
"Plug 'HonkW93/automatic-verilog'
"Plug 'tomasr/molokai'   " color scheme

call plug#end()

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
    "set guifont=Fira_Code:h14
    silent! vunmap <C-X>
    "language message zh_CN.UTF-8
    "处理菜单及右键菜单乱码
    "source $VIMRUNTIME/delmenu.vim
    "source $VIMRUNTIME/menu.vim
    "unmap <C-V>
    "cunmap <C-V>
    "unmap <C-Y>
    "iunmap <C-Y>
    " tags
    "colorscheme pablo
    "colorscheme desert
    "colorscheme delek
    let g:tagbar_ctags_bin = '$HOME/vimfiles/ctags/ctags.exe'
    "let g:pydiction_location = '$HOME/vimfiles/bundle/pydiction/complete-dict'
elseif has('unix')
    let g:tagbar_ctags_bin = '/usr/bin/ctags'
    "let g:pydiction_location = '$HOME/.vim/bundle/pydiction/complete-dict'
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
set foldlevel=0
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
autocmd vimenter * ++nested colorscheme gruvbox
"colorscheme  molokai  
"set t_Co=256
set background=dark
"set background=light

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
set tags=./tags;/
"set tags=./tags;,tags;
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
"autocmd BufRead,BufNewFile *.wsdl setf xml
"autocmd BufRead,BufNewFile *.xsd setf xml
"autocmd BufRead,BufNewFile *.lisa setf c
" file type set ******************


" syntax check ******************
"let g:syntastic_mode_map = {
"    \ "mode": "passive",
"    \ "active_filetypes": ["ruby", "php", "systemverilog"],
"    \ "passive_filetypes": ["puppet"] }
"
"    "\ "active_filetypes": ["ruby", "php", "cpp", "c", "systemverilog"],
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
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" easy align ******************
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


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
" ** vim rst wiki set -- RIV ******************
    let proj1 = { 'name': 'work', 'path': '~/wiki/work',}
    let proj2 = { 'name': 'block', 'path': "/home/lhy/work/block_chip/doc" }
    let proj3 = { 'name': 'proj', 'path': "~/wiki/work/project"}
    let proj4 = { 'name': 'tech', 'path': "~/wiki/tech" }
    let g:riv_auto_format_table = 0
    let g:riv_force = 1
    set mmp=2000

 
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

""Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"
"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
"    \ 'vimshell' : $HOME.'/.vimshell_hist',
"    \ 'scheme' : $HOME.'/.gosh_completions'
"        \ }
"
"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"" Plugin key-mappings.
"inoremap <expr><C-g>     neocomplete#undo_completion()
"inoremap <expr><C-l>     neocomplete#complete_common_string()
"
"" Recommended key-mappings.
"" <CR>: close popup and save indent.
"inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
"function! s:my_cr_function()
"  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
"  " For no inserting <CR> key.
"  "return pumvisible() ? "\<C-y>" : "\<CR>"
"endfunction
"" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
"" Close popup by <Space>.
""inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
"
"" AutoComplPop like behavior.
""let g:neocomplete#enable_auto_select = 1
"
"" Shell like behavior(not recommended).
""set completeopt+=longest
""let g:neocomplete#enable_auto_select = 1
""let g:neocomplete#disable_auto_complete = 1
""inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"
"" Enable omni completion.
"autocmd FileType systemverilog setlocal omnifunc=csscomplete#CompleteS

if $OS =~ "Windows.*"
    source ~/vimfiles/local.vim
else
    source ~/.vim/local.vim
endif
