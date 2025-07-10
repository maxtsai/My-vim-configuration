function! AskGeminiFunc(start, end)
  " Get the selected lines
  let l:lines = getline(a:start, a:end)
  let l:prompt = join(l:lines, "\n")

  " Send to Gemini and capture the output
  let l:output = system("python3 ~/.vim/gemini_send.py", l:prompt)

  " Open a new scratch buffer to show the response
  new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
  call setline(1, split(l:output, "\n"))
  normal! gg
endfunction

command! -range AG call AskGeminiFunc(<line1>, <line2>)


