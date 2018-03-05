"setup python for supported OSes
if has("unix")
  let s:uname = system("uname")
  if s:uname == "Darwin\n"
    let g:python_host_prog = '/opt/local/bin/python2'
    let g:python3_host_prog = '/opt/local/bin/python3'
    "for some reason, settting this does not work as expected
    "let g:ruby_host_prog = '/opt/local/bin/ruby'
  else
    "let g:python2_host_prog = '/opt/local/bin/python2'
    "let g:python3_host_prog = '/opt/local/bin/python3'
  endif
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'vim-scripts/keepcase.vim'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'davidhalter/jedi'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/neco-vim'
Plug 'zchee/deoplete-clang'
Plug 'wincent/Command-T', { 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
Plug 'icymind/NeoSolarized'
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'elzr/vim-json'
Plug 'bling/vim-airline'
Plug 'nvie/vim-flake8'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'rizzatti/dash.vim'
call plug#end()

"use deoplete
let g:deoplete#enable_at_startup=1

"configuration for ultisnips
"let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsListSnippets='<S-tab>'
let g:ultisnips_python_style='sphinx'
let g:ultisnips_python_quotion_style='double'

"ignore these files on file lists and tab completions
set wildignore=*.so,*.a,*.o,*.obj,*~,.git,*DS_Store*
set wildignore+=*.pyc,*.pyo,__pycache__/,.coverage/**,*.egg,*.egg-info,*.egg-link

"configuration for NERDTree
map <C-i> :NERDTreeToggle<CR>

"configuration for Command-T
map <C-a> :CommandT<CR>
let g:CommandTFileScanner='git'

"file reading/writing options
set title         "set terminal title
set autoread      "re-read files if they change on disk
set autowrite     "write files automatically everytime you change it
set backup        "create always backup~ files
set autoindent    "automated indentation
set tabstop=2     "make tab size (in tabbed files equals 2)
set shiftwidth=2  "advised?
set softtabstop=2
set expandtab     "make all tabs spaces, except where relevant
set smarttab      "not sure what it does...
set hlsearch      "enables search match highlight automatically
set incsearch     "enables search as we type
set ruler         "shows cursor position (with ruler)
set visualbell    "blink screen instead of beep sound
set textwidth=79  "wrap automatically in 80 columns
set showmatch     "to show matching pairs of brackets or braces
set modeline      "let local buffers modify variables
set backspace=indent,eol,start "fixes backspace

"color scheme/theme
set termguicolors "finer colors
set bg=dark "use dark background on guis
colorscheme NeoSolarized

"temporarily disables highlighting with <SPACE>
nmap <SPACE> <SPACE>:noh<CR>

"display options
syntax enable "enable code highlighting
syntax sync fromstart "always scan the whole file

"these mappings will help you when the screen gets bad
map <F12> :syntax sync fromstart<cr>
imap <F12> <esc>:syntax sync fromstart<cr>
vmap <F12> :syntax sync fromstart<cr>

"for tab movement
map <C-left> gT
map <C-right> gt

"set cursorline

"html editing does not need line breaking...
autocmd FileType html set textwidth=0

"makefile editing stuff
autocmd FileType make set noexpandtab

"my abbreviations
source ~/.vim/abbreviations.vim

"airline configuration
set laststatus=2
let g:airline_theme='luna'
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

"show trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace guibg=red
autocmd BufEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/

"strip trailing whitespaces
autocmd FileType * autocmd BufWritePre <buffer> :%s/\s\+$//e

"airline configuration
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#whitespace#enabled = 1

"flake8 configuration
let g:flake8_show_in_file=1

"Indent guides configuration
let g:indent_guides_guide_size=1
