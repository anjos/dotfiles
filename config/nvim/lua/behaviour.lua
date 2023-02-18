vim.opt.mouse = ''        -- Mouse work fine against terminal neovim
vim.opt.title = true      -- set terminal title
vim.opt.autoread = true   -- re-read files if they change on disk
vim.opt.autowrite = true  -- write files automatically everytime you change it
vim.opt.backup = true     -- create always backup~ files
vim.opt.autoindent = true -- automated indentation
vim.opt.tabstop = 4       -- make tab size (in tabbed files equals 4)
vim.opt.shiftwidth = 4    -- advised?
vim.opt.expandtab = true  -- make all tabs spaces, except where relevant
vim.opt.hlsearch = true   -- enables search match highlight automatically
vim.opt.incsearch = true  -- enables search as we type
vim.opt.ruler = true      -- shows cursor position (with ruler)
vim.opt.visualbell = true -- blink screen instead of beep sound
vim.opt.textwidth = 79    -- wrap automatically in 80 columns
vim.opt.showmatch = true  -- to show matching pairs of brackets or braces
vim.opt.modeline = true   -- let local buffers modify variables
vim.opt.backspace = {'indent','eol','start'}  -- fixes backspace

-- HTML editing does not need line breaking...
vim.api.nvim_create_autocmd("FileType",
  { pattern = { "html" }, command = [[set textwidth=0]] }
)

-- Do not expand tabs in Makefiles
vim.api.nvim_create_autocmd("FileType",
  { pattern = { "make" }, command = [[set noexpandtab]] }
)

-- Strip trailing whitespaces on save, without confirmation
vim.g.better_whitespace_enabled = 1
vim.g.strip_whitespace_on_save = 1
vim.g.strip_whitespace_confirm = 0

-- Ignore these files on file lists and tab completions
vim.opt.wildignore = {
	'*.a',
	'*.egg',
	'*.egg-info',
	'*.egg-link',
	'*.o',
	'*.obj',
	'*.pyc',
	'*.pyo',
	'*.so',
	'*/cache/*',
	'*/tmp/*',
	'*DS_Store*',
	'*~',
	'.coverage/**',
	'.git',
	'__pycache__/',
}

-- change the leader key from "\" to ";" ("," is also popular)
vim.g.mapleader = ';'
vim.g.maplocalleader = ';'

-- Temporarily disables highlighting with <SPACE>
vim.keymap.set('n', '<SPACE>', '<SPACE>:noh<CR>')

-- Make Y yank the whole line
vim.keymap.set('n', 'Y', 'yy')

-- Shortcut to edit THIS configuration file: (e)dit (c)onfiguration
vim.keymap.set('n', '<leader>ec', ':e $MYVIMRC<CR>', {noremap = true, silent = true})

-- Shortcut to source (reload) THIS configuration file after editing it:
vim.keymap.set('n', '<leader>sc', ':source $MYVIMRC<CR>', {noremap = true, silent = true})

-- use ;; for escape (iPad keyboard)
-- http://vim.wikia.com/wiki/Avoid_the_escape_key
vim.keymap.set('i', ';;', '<Esc>', {noremap = true})

-- If asked to display special characters (whitespaces), then use these symbols
vim.opt.listchars='eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣'
