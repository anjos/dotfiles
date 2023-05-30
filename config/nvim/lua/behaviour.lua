-- [[ Setting options ]]
-- See `:help vim.o`
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
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
vim.o.ignorecase = true   -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

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

-- If asked to display special characters (whitespaces), then use these symbols
vim.opt.listchars='eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣'

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
require('telescope').load_extension('fzf')

-- Temporarily disables highlighting with <SPACE>
vim.keymap.set('n', '<SPACE>', '<SPACE>:noh<CR>')

-- Make Y yank the whole line
vim.keymap.set('n', 'Y', 'yy')

-- use ;; for escape (iPad keyboard)
-- http://vim.wikia.com/wiki/Avoid_the_escape_key
vim.keymap.set('i', ';;', '<Esc>', {noremap = true})

-- See `:help telescope.builtin`
local wk = require('which-key')
wk.register({
  ["<leader>ei"] = {"<cmd>edit $MYVIMRC<cr>", "[E]dit neovim's [i]nit.lua", noremap = true, silent = true},
  ["<leader>si"] = {"<cmd>source $MYVIMRC<cr>", "[S]ource neovim's [i]nit.lua", noremap = true, silent = true},
  ["<leader>?"] = { "<cmd>Telescope oldfiles<cr>", "[?] Open recent file" },
  ["<leader><space>"] = { "<cmd>Telescope buffers<cr>", "[<space>] Open recent buffer" },
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  ["<leader>/"] = { function() require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown { winblend = 10, previewer = false, }) end, '[/] Fuzzily search in current buffer' },
  ["<leader>gf"] =  { "<cmd>Telescope git_files<cr>", "Search [g]it [f]iles" },
  ["<leader>s"] =  {
    f = { "<cmd>Telescope find_files<cr>", "[S]earch [f]iles" },
    h = { "<cmd>Telescope help_tags<cr>", "[S]earch [h]elp" },
    g = { "<cmd>Telescope live_grep<cr>", "[S]earch with [g]rep" },
    w = { "<cmd>Telescope grep_string<cr>", "[S]earch current [w]ord with grep" },
    d = { "<cmd>Telescope diagnostics<cr>", "[S]earch [d]iagnostics" },
  },
})
