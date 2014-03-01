filetype off "required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"let Vundle manage Vundle
Bundle 'gmarik/vundle'

"original repos on GitHub
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/keepcase.vim'
Bundle 'SirVer/ultisnips'
Bundle 'davidhalter/jedi-vim'
Bundle 'scrooloose/nerdtree'
Bundle 'wincent/Command-T'
Bundle 'altercation/vim-colors-solarized'

"configuration for ultisnips
"let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsListSnippets='<s-tab>'
let g:ultisnips_python_style='sphinx'
let g:ultisnips_python_quotion_style='double'

"configuration for NERDTree
map <C-i> :NERDTreeToggle<CR>

"configuration for Command-T
map <C-a> :CommandT<CR>

filetype plugin indent on

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
set number "shows the line numbers
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
if has("gui_macvim")
  set transparency=5
  set guioptions=egmrLt
endif

"Show trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

"Strip trailing whitespaces
autocmd FileType c,cpp,java,php,ruby,python,text,rst autocmd BufWritePre <buffer> :%s/\s\+$//e

"Allows us to find .vimrc files locally
set exrc   " scans for per-directory settings for vim
set secure " disables unsafe commands in local .vimrc files
