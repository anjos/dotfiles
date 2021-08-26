"setup python/ruby/node
let $PATH = '/Users/andre/conda/envs/neovim/bin:' . $PATH
let g:python_host_prog = '/Users/andre/conda/envs/neovim2/bin/python2'
let g:python3_host_prog = '/Users/andre/conda/envs/neovim/bin/python3'
let g:ruby_host_prog = '/Users/andre/.gem/ruby/3.0.0/bin/neovim-ruby-host'
let g:node_host_prog = '/Users/andre/conda/envs/neovim/lib/node_modules/neovim/bin/cli.js'
let g:coc_node_path = '/Users/andre/conda/envs/neovim/bin/node'

call plug#begin('~/.local/share/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'kevinoid/vim-jsonc'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/keepcase.vim'
Plug 'wincent/Command-T', { 'do': 'cd ruby/command-t/ext/command-t && /usr/local/opt/ruby/bin/ruby extconf.rb && make' }
Plug 'w0ng/vim-hybrid'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'rizzatti/dash.vim'
Plug 'lervag/vimtex'
Plug 'ambv/black'
Plug 'tpope/vim-eunuch'
call plug#end()

"define standard coc extensions
let g:coc_global_extensions = [
            \ 'coc-pyright',
            \ 'coc-sh',
            \ 'coc-vimlsp',
            \ 'coc-texlab',
            \ 'coc-css',
            \ 'coc-calc',
            \ 'coc-json',
            \]

"open new window when running the plugin admin commands
let g:plug_window = 'botright new'

"let mouse work fine against terminal neovim
set mouse=a

" Paste with middle mouse click
vmap <LeftRelease> "*ygv

"configuration for ultisnips
"let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsListSnippets='<S-tab>'
let g:ultisnips_python_style='sphinx'
let g:ultisnips_python_quotion_style='double'

"ignore these files on file lists and tab completions
set wildignore=*.so,*.a,*.o,*.obj,*~,.git,*DS_Store*
set wildignore+=*.pyc,*.pyo,__pycache__/,.coverage/**,*.egg,*.egg-info,*.egg-link

"configuration for Command-T
map <C-a> :CommandT<CR>
let g:CommandTFileScanner='find'

"file reading/writing options
set title         "set terminal title
set autoread      "re-read files if they change on disk
set autowrite     "write files automatically everytime you change it
set backup        "create always backup~ files
set autoindent    "automated indentation
set tabstop=4     "make tab size (in tabbed files equals 4)
set shiftwidth=4  "advised?
set expandtab     "make all tabs spaces, except where relevant
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
colorscheme hybrid

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

"airline configuration
set laststatus=2
let g:airline_theme='wombat'
let g:airline_powerline_fonts=1

"show trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace guibg=red
autocmd BufEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhiteSpace /\s\+$/

"strip trailing whitespaces
autocmd FileType * autocmd BufWritePre <buffer> :%s/\s\+$//e

"jsonc settings
autocmd BufRead,BufNewFile coc-settings.json set filetype=jsonc

"airline configuration
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#whitespace#enabled = 1

"show line numbers and make double-C-n switch modes
set nonumber
set numberwidth=4
:nmap <C-N><C-N> :set invnumber<CR>

"Indent guides configuration
let g:indent_guides_guide_size=1

"let me manage the gutter color, always show the bar
let g:gitgutter_grep=''
let g:gitgutter_override_sign_column_highlight = 0
set signcolumn=yes
highlight SignColumn ctermbg=232
highlight SignColumn guibg=#0f0f0f

"look for the "theme"
let $TEXINPUTS = "$PWD:$PWD/theme:"
"use nvr (required by vim-tex)
let g:vimtex_compiler_progname = '/Users/andre/conda/envs/neovim/bin/nvr'
let g:vimtex_view_method = 'skim'
let g:tex_flavor = 'latex'

"where to put black
let g:black_virtualenv = stdpath('data').'/black'
let g:black_linelength = 80

"Use ctrl-d as quit alternative
noremap <C-d> :q<cr>

"change the leader key from "\" to ";" ("," is also popular)
let mapleader = ";"
let maplocalleader = ';'

"Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
nnoremap <silent> <leader>ec :e $MYVIMRC<CR>

"Shortcut to source (reload) THIS configuration file after editing it: (s)ource
"(c)onfiguraiton
nnoremap <silent> <leader>sc :source $MYVIMRC<CR>

"use ;; for escape
"http://vim.wikia.com/wiki/Avoid_the_escape_key
inoremap ;; <Esc>
