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
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
  autocmd FileType make set tabstop=8 shiftwidth=8 softtabstop=0 noexpandtab
  autocmd FileType java set tabstop=4 shiftwidth=4 softtabstop=0 expandtab
  autocmd FileType cpp set tabstop=4 shiftwidth=4 softtabstop=0 expandtab
  autocmd FileType aidl set tabstop=4 shiftwidth=4 softtabstop=0 expandtab
endif
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set hidden             " Hide buffers when they are abandoned
set hls
set nocompatible
set number
set hlsearch
set backspace=indent,eol,start
"set mouse=a

"folding
set foldmethod=syntax
set foldlevel=100
set foldenable
set foldcolumn=0
set foldnestmax=3
set foldexpr=1

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

""""""""""""""""""""""""""""""""""""""
" // vim: ts=4 sw=4 et in source code
""""""""""""""""""""""""""""""""""""""
set modeline
set modelines=2


hi clear

set t_Co=256 " 256 colors

"colorscheme 256-jungle
"colorscheme tender
colorscheme vividchalk
"colorscheme ir_black
"colorscheme mayansmoke
"colorscheme gruvbox
"colorscheme codedark
"colorscheme solarized
"colorscheme corporation
"colorscheme mine


""""""""""""""""""""""""""""""""""""""
let g:kolor_italic=1
let g:kolor_bold=1
let g:kolor_underlined=0
let g:kolor_alternative_matchparen=0
let g:kolor_inverted_matchparen=0
"colorscheme kcolor
""""""""""""""""""""""""""""""""""""""

"hi Normal ctermbg=17
"highlight Search term=reverse ctermbg=4 ctermfg=7
"highlight Normal ctermbg=black ctermfg=green
"hi Comment ctermfg=darkcyan

set fenc=utf-8
set fencs=utf-8,usc-bom,euc-jp,gb18030,gbk,gb2312,cp936
if version >= 603
	set helplang=tw
	set encoding=utf-8
endif


map ,r :History<CR>
map ,w :set wrap!<CR>
map ,n :set nu!<CR>
map ,s :set cursorline!<CR>:set cursorcolumn!<CR>
map ,h :MRU <CR>

"map <F5> :lv /<c-r>=expand("<cword>")<cr>/ **/* <cr>:lw <CR>
"map <F6> :SaveSession <CR>
"map <F6> :cd %:h <CR>
"map <F4> :syntax off <CR>
map <F5> :NERDTree <CR>

map <F7> <ESC>:TagbarToggle<ENTER>
map <F8> <ESC>:Tlist<ENTER>
map <F9> :BufExplorer <CR>
map <F12> :qa <CR>

" print debug 
let @1="printk(\"+++ \%s:\%d\\n\", __func__, __LINE__);"
let @2="printf(\"+++ \%s:\%d\\n\", __FUNCTION__, __LINE__);"
let @3=strftime("// Max Tsai: %d/%m/%y %H:%M:%S")

"Most recently used
let MRU_Max_Entries = 200


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

if has("autocmd")
autocmd BufEnter * :syntax sync fromstart " ensure every file does syntax highlighting (full)
endif


""""""""""""""""""""""""""""""
" highlight the part over right margin
""""""""""""""""""""""""""""""
"highlight rightMargin ctermfg=green
"match rightMargin /.\%>81v/


""""""""""""""""""""""""""""""
" Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2
let g:Powerline_symbols = 'fancy'
let Powerline_symbols='compatible'


"" dislabe session autoload
let g:session_autoload = 'no'
let g:session_autosave = 'no'

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
if has("autocmd")
autocmd BufWinEnter \[Buf\ List\] setl nonumber
endif


""""""""""""""""""""""""""""""
" keep cscope result in quickfix
""""""""""""""""""""""""""""""
set cscopequickfix=c-,d-,e-,g-,i-,s-,t-
"set cscopeverbose
"nmap <C-n> :cnext<CR>
"nmap <C-p> :cprev<CR>
"nmap <C-t> :colder<CR>:cc<CR>
run plugin/cscope_map.vim


""""""""""""""""""""""""""""""
" vimgdb
""""""""""""""""""""""""""""""
set previewheight=17            " set gdb window initial height
run macros/gdb_mappings.vim
"set asm=0                       " don't show any assembly stuff|

"""""""""""""""""""""""""""""
"nmap ,e :tab sp <C-R>=expand("%:h") . "/" <CR>
nmap ,e :tab sp

" Use Ctrl+q for Visual Block mode
noremap <C-q> <C-v>

"" speed up when syntax on
set ttyfast
set lazyredraw

"" shell command output to quickfix
command -nargs=+ Run :cexpr system('<args>') | copen

if has("autocmd")
"" preview markdown file in chrome. Need chrome with markdown extension
autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} map <Leader>p :!google-chrome-stable %:p &>/dev/null &<CR>
endif

finish

alias icdiff='icdiff --highlight'

