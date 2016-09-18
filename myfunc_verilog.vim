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
      "call setline(1,"`timescale 1ns/1ps")
      "call setline(2,"// file name: .expand(%))
      "call setline(3,"// author: lianghy")
      "call setline(4,"// time: ".strftime("%c"))
      "call setline(5,"")
      call setline(1,"module (/*autoarg*/")
      call setline(2,");")
      call setline(3,"endmodule")
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

func! addHead()
    call s:YSetTitle()
endfunc
