""" soft link to ~/.config/nvim/init.vim


set runtimepath^=~/.vim
set runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vim/vimrc


" Add the following to your ~/.config/nvim/init.vim or source from another .vim file

" Set runtime path (in case you're sharing .vim config)
set rtp+=~/.fzf

" --- FZF command wrappers (lowercase) ---

command! -nargs=* Vupdate call s:UpdateFzfIndex(<f-args>)
function! s:UpdateFzfIndex(...) abort
  let l:args = a:000
  let l:cmd = shellescape(expand('~/bin/update_fzf_index.sh'))

  if len(l:args) > 0
    let l:escaped_args = map(copy(l:args), 'shellescape(v:val)')
    let l:cmd .= ' ' . join(l:escaped_args, ' ')
  endif

  let l:output = system(l:cmd)
  echo l:output
endfunction


command! -nargs=? Vf call <SID>VF(<f-args>)

function! s:FindNearestFzfIndex()
  let l:dir = getcwd()
  let l:home = expand('$HOME')
  while l:dir !=# l:home && l:dir !=# '/'
    let l:index = l:dir . '/.fzf-index-files'
    if filereadable(l:index)
      return l:index
    endif
    let l:dir = fnamemodify(l:dir, ':h')
  endwhile
  return l:home . '/.fzf-index-files'
endfunction

function! s:VF(...) abort
  let l:search = get(a:000, 0, '')
  let l:index_file = s:FindNearestFzfIndex()
  if !filereadable(l:index_file)
    echohl WarningMsg | echom "❌ No .fzf-index-files found." | echohl None
    return
  endif
  let l:files = readfile(l:index_file)
  if !empty(l:search)
    let l:files = filter(copy(l:files), 'v:val =~? l:search')
  endif
  call fzf#run(fzf#wrap({ 'source': l:files, 'sink': 'edit' }))
endfunction

command! -nargs=1 Vseek call fzf#run(fzf#wrap({
      \ 'source': 'rg --line-number --no-heading --color=always '.shellescape(<q-args>),
      \ 'sink':   function('s:RipgrepSink'),
      \ 'options': '--ansi --delimiter ":" --nth 3.. --preview "bat --style=numbers --color=always {1} --line-range {2}: 2>/dev/null || cat {1}"'
      \ }))
function! s:RipgrepSink(line)
  let l:parts = split(a:line, ':')
  if len(l:parts) >= 2
    let l:file = trim(l:parts[0])
    let l:line_number = trim(l:parts[1])
    if filereadable(l:file)
      execute 'edit +' . l:line_number . ' ' . fnameescape(l:file)
    else
      echohl ErrorMsg | echom "❌ File not found: " . l:file | echohl None
    endif
  else
    echohl WarningMsg | echom "⚠️ Unexpected format: " . a:line | echohl None
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
  echo "  :Vupdate [-f] → Refresh the file index (skips .git/build/tmp)"
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






"""""""""""" LLM CLI
lua << EOF
function AskGroqRightTerminal()
  vim.ui.input({ prompt = "Ask Groq: " }, function(input)
    if input == nil or input == '' then return end

    -- Sanitize user input for shell
    input = input:gsub("'", "'\\''")

    -- Construct the shell command
    local cmd = "echo '" .. input .. "' | python3 ~/.vim/groqcloud_send.py"

    -- Open vertical split on the right and run terminal with command
    vim.cmd("vsplit")                    -- open right vertical window
    vim.cmd("terminal " .. cmd)         -- run your LLM script inside it
    vim.cmd("startinsert")              -- auto enter insert mode in terminal
  end)
end

-- Map it to <leader>g (change this if your leader is space or comma)
vim.api.nvim_set_keymap('n', '<leader>g', ':lua AskGroqRightTerminal()<CR>', { noremap = true, silent = true })
EOF

