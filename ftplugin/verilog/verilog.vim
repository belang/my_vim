if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1  " Don't load another plugin for this buffer
set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=79 
set expandtab 
set autoindent 

" always
nnoremap <C-E>aph :call Always(1, 1)<cr>
nnoremap <C-E>apl :call Always(1, 0)<cr>
nnoremap <C-E>anh :call Always(0, 1)<cr>
nnoremap <C-E>anl :call Always(0, 0)<cr>
nnoremap <C-E>gnl :call GenNumList()<cr>

nmap ; A;<Esc>
vmap ; :s/$/;/<cr>/asdf<cr>

if !exists("*s:pbegin_add")
  "delfunction s:pbegin_add
  function s:pbegin_add()
    execute "normal! aif () begin\rend\relse begin\rend"
    execute "normal! kkk"
  endfunction
  inoremap <buffer> if<Space>begin <Esc>:call <SID>pbegin_add()<cr>
"endif

" verilog header:
"if !exists("YSetTitle")
  func s:YSetTitle()
    if &filetype == 'verilog'
      call setline(1,"`timescale 1ns/1ps")
      call setline(2,"// file name: ".expand("%"))
      call setline(3,"// author: lianghy")
      call setline(4,"// time: ".strftime("%c"))
      call setline(5,"")
      call setline(6,"module (")
      call setline(7,");")
      call setline(8,"endmodule")
    endif
  endfunc
  func! PFmoveDefine()
    for line in getline(1, line("$"))
      if line ~= '^always ' || line ~= '^assign '
        let s:llinepos = line('.')-1
        break
      endif
    endfor
    if exist("s:llinepos")
      for line in getline(1, line("$"))
        if line ~= '^reg ' || line ~= '^wire '
          break
        endif
      endfor
    endif
  endfunc
endif
func! Always(pos_neg, high_low)
  let cur_line = line('.')
  let lines = "always @("
  if a:pos_neg == 1
    let lines .= "posedge clk) begin"
  else  
    let lines .= "negedge clk) begin"
  endif
  call append(cur_line, lines)
  let cur_line += 1
  let lines = "    if ("
  if a:high_low == 1
    let lines .= "rst_n) begin"
  else  
    let lines .= "!rst) begin"
  endif
  call append(cur_line, lines)
  let cur_line += 1
  let lines = "    end else begin"
  call append(cur_line, lines)
  let cur_line += 1
  let lines = "    end"
  call append(cur_line, lines)
  let cur_line += 1
  let lines = "end"
  call append(cur_line, lines)
endfunc

func! GenNumList()
	let cur_line = line('.')
	for i in range(10)
		call append(cur_line, i)
		let cur_line += 1
	endfor
endfunc

func! AddHead()
    call s:YSetTitle()
endfunc
