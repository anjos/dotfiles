set nocompatible "do not run in vi compatibility mode
filetype off "required
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

"let Vundle manage Vundle
Plugin 'gmarik/vundle'

"original repos on GitHub
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/keepcase.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'wincent/Command-T'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ervandew/supertab'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

if has("gui_running")
  Plugin 'bling/vim-airline'
endif

call vundle#end() "required
filetype plugin indent on "re-enable indentation

"configuration for ultisnips
"let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsListSnippets='<S-tab>'
let g:ultisnips_python_style='sphinx'
let g:ultisnips_python_quotion_style='double'

"configuration for NERDTree
map <C-i> :NERDTreeToggle<CR>

"configuration for Command-T
map <C-a> :CommandT<CR>

"file reading/writing options
set nocompatible      "be iMproved, remove old vi compatibility hacks
set autoread          "re-read files if they change on disk
set autowrite         "write files automatically everytime you change it
set backup            "create always backup~ files
set autoindent        "automated indentation
set tabstop=2         "make tab size (in tabbed files equals 2)
set shiftwidth=2      "advised?
set softtabstop=2
set expandtab         "make all tabs spaces, except where relevant
set hlsearch          "enables search match highlight automatically
set incsearch         "enables search as we type
set ruler             "shows cursor position (with ruler)
set visualbell        "blink screen instead of beep sound
set textwidth=79 "wrap automatically in 80 columns
set showmatch "to show matching pairs of brackets or braces
set modeline "let local buffers modify variables
set backspace=indent,eol,start "fixes backspace
set bg=dark "use dark background on guis
colorscheme solarized

"temporarily disables highlighting with <SPACE>
nmap <SPACE> <SPACE>:noh<CR>

"display options
"set number "shows the line numbers
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

"HTML editing does not need line breaking...
autocmd FileType html set textwidth=0

"Makefile editing stuff
autocmd FileType make set noexpandtab

"My abbreviations
source ~/.vim/abbreviations.vim

"Special stuff for MacOSX vim port
if has ("gui_macvim")
  "set bg=dark
  set transparency=10
endif

"Stuff we only use in gui mode
if has("gui_running")
  "Airline configuration options
  set laststatus=2
  let g:airline_powerline_fonts=1
  set noshowmode

  "Display options
  set guioptions-=m "remove menubar
  set guioptions-=T "remove toolbar
endif

"Show trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

"Strip trailing whitespaces
autocmd FileType c,cpp,java,php,ruby,python,text,rst,tex,latex autocmd BufWritePre <buffer> :%s/\s\+$//e

"Allows us to find .vimrc files locally
set exrc   " scans for per-directory settings for vim
set secure " disables unsafe commands in local .vimrc files

"Airline configuration
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#whitespace#enabled = 1
