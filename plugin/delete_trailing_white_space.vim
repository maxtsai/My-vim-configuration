function! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunction
command! -nargs=0 CleanTrailingWS :call DeleteTrailingWS()
