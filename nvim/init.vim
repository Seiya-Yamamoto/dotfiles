"  ___    ___ ________  _____ ______   ________  ________  _______   ________    
" |\  \  /  /|\   __  \|\ _ \  _   \|\   __  \|\   ____\|\  ___ \ |\   ___  \    
" \ \  \/  / | \  \|\  \ \  \\\__\ \  \ \  \|\  \ \  \___|\ \ __/|\ \  \\ \  \   
"  \ \    / / \ \ __  \ \  \\|__| \  \ \   __  \ \  \  __\ \  \_|/_\ \  \\ \  \  
" \/  /  /   \ \  \ \  \ \  \    \ \  \ \  \ \  \ \  \|\  \ \  \_|\ \ \  \\ \  \ 
" __/  / /    \ \__\ \__\ \__\  \ \__\ \__\ \__\ \_______\ \_______\ \__\\ \__\
"|\___/ /    \|__|\|__|\|__|   \|__|\|__|\|__|\|_______|\|_______|\|__| \|__|
"\|___|/                                       
"

let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

" dein {{{
let s:dein_cache_dir = g:cache_home . '/dein'

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

if &runtimepath !~# '/dein.vim'
  let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

  " Auto Download
  if !isdirectory(s:dein_repo_dir)
    call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
  endif

  " Load Dein.vim
  execute 'set runtimepath^=' . s:dein_repo_dir
endif

" dein.vim settings
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#install_message_type = 'none'
let g:dein#enable_notification = 1

if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)

  let s:toml_dir = g:config_home . '/nvim'

  call dein#load_toml(s:toml_dir . '/plugins.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/lazy.toml', {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}


"----------------------------------------------------------
" Character Code:

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double  "Display double-width symbols properly


"----------------------------------------------------------
" Status Line:

set laststatus=2
set showmode
set showcmd
"set ruler


"----------------------------------------------------------
" Command Mode:

set wildmenu
set history=200


"----------------------------------------------------------
" Tab Indent:

set expandtab " Replace tab input with multiple blank inputs
"set noexpandtab " Disable expandtab

set autoindent
set smartindent " Check the syntax of the previous line on line feed and increase / decrease the indent of the next line

set tabstop=2 " Tab Width
set shiftwidth=2 " smartindent Width
set softtabstop=0


"----------------------------------------------------------
" Appearance:

set list
set listchars=tab:¦_,trail:-,nbsp:%,eol:↲,extends:»,precedes:«,nbsp:%


"----------------------------------------------------------
" String Search:

set incsearch " Incremental search. Perform a search for each character entry
set ignorecase " Searching without distinguishing uppercase and lowercase letters
set smartcase " If the search pattern contains uppercase letters, distinguish case
set hlsearch " Highlight search results

" Toggle highlighting by pressing the ESC key twice
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>


"----------------------------------------------------------
" Cursor:

set number " Show line number
highlight LineNr ctermfg=lightgray " Line number color
set cursorline " Highlight the cursor line

" If the line is displayed by wrapping, move the cursor by display line instead of line by line
" Because it interferes with accelerated-jk, it is invalid
"nnoremap j gj
"nnoremap k gk

" Restore last cursor position
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \ exe "normal! g'\"" |
  \ endif
endif

" Activate backspace key
set backspace=indent,eol,start


"----------------------------------------------------------
" Parentheses Tags:

set showmatch " Display the correspondence of parentheses for a moment
source $VIMRUNTIME/macros/matchit.vim " Extend "%" of Vim


"----------------------------------------------------------
" Copy Paste:

set clipboard=unnamed,unnamedplus " Use OS Clipboard

" Do not yank when deleting
"nnoremap x "_x
"nnoremap d "_d
"nnoremap D "_D<Paste>


"----------------------------------------------------------
" Save File:

" Do not create backup files
set nobackup

" Do not create swap file
set noswapfile
