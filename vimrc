" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
"if has("autocmd")
"  filetype indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals
set cindent
"set smartindent
set hls
set nocompatible
"set sw=3
set number
set hlsearch
set foldmethod=syntax
set foldlevel=100 "don't autofold anything
" set foldmethod=indent
set ruler
set cursorline
set viminfo+=!
set autoread
set confirm
set clipboard+=unnamed "share clipboard with windows
set noswapfile
set nobackup
set bufhidden=hide "当buffer被丢弃的时候隐藏它
set noerrorbells
"set autochdir
hi clear

filetype on

"au BufWinLeave * silent mkview
"au BufWinEnter * silent loadview

"在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\

set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif


highlight Search term=reverse ctermbg=4 ctermfg=7
" highlight Normal ctermbg=black ctermfg=grey 
hi Comment ctermfg=darkcyan 

map ,h :nohl<CR>
map ,w :set wrap!<CR>
map ,n :set nu!<CR>
map ,s :set cursorline!<CR>:set cursorcolumn!<CR>

map <F2> :r /home/max/bin/debug_printk.txt<CR>
map <F3> :r /home/max/bin/debug_printf.txt<CR>
map <F5> <ESC>:Tlist<ENTER>
map <F6> <ESC>:vsplit<ENTER>:edit $PWD/.<ENTER>
map <F7> :BufExplorer <CR>

map <F11> :lv /<c-r>=expand("<cword>")<cr>/ **/* <cr>:lw <CR>
map <F12> :qa <CR>

"let Tlist_Inc_Winwidth=0
let Tlist_Ctags_Cmd="/usr/bin/ctags"
let JavaBrowser_Ctags_Cmd="/usr/bin/ctags"
"let Tlist_Ctags_Cmd = "/usr/bin/ctags-exuberant" " Location of my ctags
let Tlist_Sort_Type = "name" " order by
let Tlist_Use_Right_Window = 1 " split to the left side of the screen
"let Tlist_Compart_Format = 1 " show small meny
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_File_Fold_Auto_Close = 1 " Do not close tags for other files
let Tlist_Enable_Fold_Column = 1 " Do not show folding tree
let Tlist_Show_One_File = 1 "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exit_OnlyWindow = 1

autocmd BufEnter * :syntax sync fromstart " ensure every file does syntax highlighting (full)
"au BufEnter /usr/include/c++/*   setf cpp " all the file under the directory are recognized as cpp files by vim

"let g:explVertical=1 " should I split verticially
"let g:explWinSize=35 " width of 35 pixels

"" update cscope database automatically
" nmap <F9> :!find . -iname '*.c' -o -iname '*.cpp' -o -iname '*.h' -o -iname '*.hpp' > cscope.files ;
"  \ cs kill -1<CR>:cs add cscope.out<CR>

"" highlight the part over right margin
"highlight rightMargin ctermfg=green
"match rightMargin /.\%>81v/


""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
set statusline=\ WorkDir:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c
"set statusline+=\ buf:%2*%-3.3n%0*\
"set statusline+=%f\ " file name
"set statusline+=%h%1*%m%r%w%0* " flag
function! CurDir()
    let curdir = substitute(getcwd(), '/home/max/', "~/", "g")
    return curdir
endfunction

""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=1  " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber 

""""""""""""""""""""""""""""""
" Delete trailing white space
""""""""""""""""""""""""""""""
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.[ch] :call DeleteTrailingWS()
autocmd BufWrite *.cpp :call DeleteTrailingWS()
autocmd BufWrite *.java :call DeleteTrailingWS()


""""""""""""""""""""""""""""""
" Vimwiki
""""""""""""""""""""""""""""""
"let g:vimwiki_folding = 1
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,br,hr,div,del,code,pre'
let g:vimwiki_camel_case=0
let g:vimwiki_hl_cb_checked=1
let g:vimwiki_CJK_length=1
let g:vimwiki_list = [{'path': '~/vimwiki/', 'path_html': '~/desktop/myWiki'}]
" make local commands work (for ex., Vimwiki2HTML)
set nocompatible
filetype plugin on
finish

