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
set background=light  
filetype indent on
"set cursorline

"Python editting stuff
autocmd FileType *.py source ~/.vim/python.vim

"My abbreviations
source ~/.vim/abbreviations.vim

"Skeletons
source ~/.vim/plugin/templatefile.vim
