"file reading/writing options
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

filetype plugin indent on
"set cursorline

"Python editing stuff
autocmd BufRead,BufNewFile SConstruct setfiletype python
autocmd FileType python source ~/.vim/python.vim

"CMake stuff
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in runtime! indent/cmake.vim
autocmd BufRead,BufNewFile *.cmake,CMakeLists.txt,*.cmake.in setf cmake
autocmd BufRead,BufNewFile *.ctest,*.ctest.in setf cmake

"HTML editing does not need line breaking...
autocmd FileType html set textwidth=0

"Makefile editing stuff
autocmd FileType make set noexpandtab

"For views and sessions
set sessionoptions="buffers,folds,options,tabpages,winpos,sesdir,globals,localoptions"

"My abbreviations
source ~/.vim/abbreviations.vim

"Skeletons
source ~/.vim/plugin/templatefile.vim

"Spelling (use this only with vim >= 7)
map <F6> :set nospell<cr>
imap <F6> <esc>:set nospell<cr>
vmap <F6> :set nospell<cr>
map <F7> :setlocal spell spelllang=en<cr>
imap <F7> <esc>:setlocal spell spelllang=en<cr>
vmap <F7> :setlocal spell spelllang=en<cr>
map <F8> :setlocal spell spelllang=pt<cr>
imap <F8> <esc>:setlocal spell spelllang=pt<cr>
vmap <F8> :setlocal spell spelllang=pt<cr>

"Special stuff for MacOSX vim port
if has ("gui_macvim")
  "set bg=dark
  set transparency=10
endif

"This will setup a few project tags
autocmd BufEnter ~/work/torch/* :setlocal tags+=~/work/torch/ctags

"This will setup a few abbreviations I normally use
abbrev <expr> datestr strftime("%c")
abbrev namemail Andre Anjos <andre.dos.anjos@gmail.com>
abbrev inamemail Andre Anjos <andre.anjos@idiap.ch>
abbrev vimutf8 vim: set fileencoding=utf-8 :
