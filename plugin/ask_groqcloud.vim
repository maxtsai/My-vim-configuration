function! AskGrokFunc(start, end)
  let l:lines = getline(a:start, a:end)
  let l:prompt = join(l:lines, "\n")

  " Call the new script
  let l:output = system("python3 ~/.vim/grokcloud_send.py", l:prompt)

  " Show output
  new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  call setline(1, split(l:output, "\n"))
  normal! gg
endfunction

command! -range AGC call AskGrokFunc(<line1>, <line2>)

