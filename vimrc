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
"Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'elzr/vim-json'
Plugin 'Pychimp/vim-luna'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tell-k/vim-autopep8'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'rizzatti/dash.vim'

call vundle#end() "required
filetype plugin indent on "re-enable indentation

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

"file reading/writing options
set autoread          "re-read files if they change on disk
set autowrite         "write files automatically everytime you change it
set backup            "create always backup~ files
set autoindent        "automated indentation
set tabstop=2         "make tab size (in tabbed files equals 2)
set shiftwidth=2      "advised?
set softtabstop=2
set expandtab         "make all tabs spaces, except where relevant
set smarttab          "not sure what it does...
set hlsearch          "enables search match highlight automatically
set incsearch         "enables search as we type
set ruler             "shows cursor position (with ruler)
set visualbell        "blink screen instead of beep sound
set textwidth=79 "wrap automatically in 80 columns
set showmatch "to show matching pairs of brackets or braces
set modeline "let local buffers modify variables
set backspace=indent,eol,start "fixes backspace
set bg=dark "use dark background on guis
colorscheme luna

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

"HTML editing does not need line breaking...
autocmd FileType html set textwidth=0

"Makefile editing stuff
autocmd FileType make set noexpandtab

"My abbreviations
source ~/.vim/abbreviations.vim

"Airline configuration
set laststatus=2
let g:airline_theme='luna'
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

"Stuff we only use in gui mode
if has("gui_running")
  set transparency=5
  set guioptions=egmrLt

  colorscheme solarized
  set noshowmode
  set guioptions-=m
  set guioptions-=T
  set guioptions+=i

  "Setup nicer fonts on guis
  if has("gui_gtk2")
    "set guifont=Inconsolata\ for\ Powerline\ 13
    set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 13
  elseif has("gui_macvim")
    set guifont=Sauce\ Code\ Powerline\ Light:h14
  endif

else

  set t_Co=256

endif

"Show trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace guibg=red
autocmd BufEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/

"Strip trailing whitespaces
autocmd FileType * autocmd BufWritePre <buffer> :%s/\s\+$//e

"Airline configuration
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#whitespace#enabled = 1

"Autopep8 configuration
autocmd FileType python map <buffer> <F3> :call Autopep8()<CR>
let g:autopep8_indent_size=2
let g:autopep8_max_line_length=79

"Indent guides configuration
let g:indent_guides_guide_size=1

"Fix/override ftplugin default tab settings for Python
function! SetupPython()
  setlocal tabstop=2
  setlocal shiftwidth=2
  setlocal softtabstop=2
endfunction
command! -bar SetupPython call SetupPython()
