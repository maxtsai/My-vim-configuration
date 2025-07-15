""" soft link to ~/.config/nvim/init.vim


set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc


" Add the following to your ~/.config/nvim/init.vim or source from another .vim file

" Set runtime path (in case you're sharing .vim config)
set rtp+=~/.fzf

" --- FZF command wrappers (lowercase) ---

command! -nargs=0 Vupdate call s:UpdateFzfIndex()
function! s:UpdateFzfIndex()
  let l:cmd = expand('~/bin/update_fzf_index.sh')
  let l:output = system(l:cmd)
  echo l:output
endfunction

command! -nargs=? Vf call <SID>VF(<f-args>)

function! s:VF(...) abort
  let l:search = get(a:000, 0, '')
  let l:files = readfile(expand('~/.fzf-index-files'))
  if !empty(l:search)
    let l:files = filter(l:files, 'v:val =~? l:search')
  endif
  call fzf#run(fzf#wrap({ 'source': l:files, 'sink': 'edit' }))
endfunction

command! -nargs=1 Vseek call fzf#run(fzf#wrap({
      \ 'source': 'rg --line-number --no-heading --color=always '.shellescape(<q-args>),
      \ 'sink':   function('s:RipgrepSink'),
      \ 'options': '--ansi --preview "bat --style=numbers --color=always {1} --line-range {2}:" --delimiter ":" --nth 3..'
      \ }))
function! s:RipgrepSink(line)
  let l:parts = split(a:line, ':')
  if len(l:parts) >= 2
    exec 'edit +' . l:parts[1] . ' ' . l:parts[0]
  endif
endfunction

command! -nargs=0 Fcd call fzf#run(fzf#wrap({
      \ 'source': 'find . -type d \( -path "*/.git" -o -path "*/build" -o -path "*/tmp" \) -prune -o -print',
      \ 'sink': function('s:ChangeDir') }))
function! s:ChangeDir(dir)
  exec 'cd ' . a:dir
  exec 'pwd'
endfunction

command! -nargs=0 Gitf call fzf#run(fzf#wrap({ 'source': 'git ls-files', 'sink': 'edit' }))
command! -nargs=0 Gitlog call fzf#run(fzf#wrap({ 'source': 'git log --oneline', 'sink': 'echo' }))
command! -nargs=0 Gitblame call fzf#run(fzf#wrap({
      \ 'source': 'git ls-files',
      \ 'sink': function('s:TigBlame') }))
function! s:TigBlame(file)
  exec 'silent !tig blame ' . a:file
  redraw!
endfunction

command! -nargs=0 Gitswitch call fzf#run(fzf#wrap({
      \ 'source': 'git branch --all | grep -v "HEAD" | sed "s/.* //"',
      \ 'sink': 'gitswitchdo' }))
command! -nargs=1 Gitswitchdo exec '!git checkout ' . <q-args>





"""""""""" fzf help
command! -nargs=0 Vhelp call s:ShowFzfHelp()

function! s:ShowFzfHelp() abort
  echo "🎯 FZF Command Reference (Neovim)"
  echo ""
  echo "  :Vupdate      → Refresh the file index (skips .git/build/tmp)"
  echo "  :Vf [term]    → Fuzzy-pick a file from index and open in vi"
  echo "  :Vfind        → Alias for :Vf"
  echo "  :Vseek <term> → Fuzzy-search text via ripgrep and jump to line"
  echo "  :Fcd          → Fuzzy cd into a subdirectory"
  echo "  :Gitf         → Fuzzy-pick a Git-tracked file and open in vi"
  echo "  :Gitlog       → Browse commit history using tig"
  echo "  :Gitblame     → Fuzzy-pick file and run 'tig blame'"
  echo "  :Gitswitch    → Fuzzy-pick and switch Git branch"
  echo ""
  echo "Tips:"
  echo "  - Ctrl+C or ESC to cancel"
  echo "  - Ctrl+U / Ctrl+D to scroll up/down"
  echo "  - Use :Vupdate after switching projects"
endfunction


