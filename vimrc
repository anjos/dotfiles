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
autocmd BufRead,BufNewFile SConscript setfiletype python
autocmd BufRead,BufNewFile wscript setfiletype python
autocmd FileType python source ~/.vim/python.vim

"HTML editing does not need line breaking...
autocmd FileType html set textwidth=0

"Makefile editing stuff
autocmd FileType make set noexpandtab

"For views -> disabled because of automatic chdir commands that never respect
"the current directory and cannot be turned off!
"autocmd BufWrite * mkview 
"autocmd BufRead * silent! loadview 

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
  set transparency=5
  set guioptions=egmrLt
endif

"This will setup a few project tags
autocmd BufEnter ~/Projects/torch/* :setlocal tags+=~/Projects/torch/ctags
