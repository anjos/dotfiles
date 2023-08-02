-- [[ Setting options ]]
-- See `:help vim.o`
vim.opt.mouse = 'a' -- Mouse work fine against terminal neovim
vim.opt.title = true -- set terminal title
vim.opt.autoread = true -- re-read files if they change on disk
vim.opt.autowrite = true -- write files automatically everytime you change it
vim.opt.backup = true -- create always backup~ files
vim.opt.autoindent = true -- automated indentation
vim.opt.tabstop = 4 -- make tab size (in tabbed files equals 4)
vim.opt.shiftwidth = 4 -- advised?
vim.opt.expandtab = true -- make all tabs spaces, except where relevant
vim.opt.hlsearch = true -- enables search match highlight automatically
vim.opt.incsearch = true -- enables search as we type
vim.opt.ruler = true -- shows cursor position (with ruler)
vim.opt.visualbell = true -- blink screen instead of beep sound
vim.opt.textwidth = 79 -- wrap automatically in 80 columns
vim.opt.showmatch = true -- to show matching pairs of brackets or braces
vim.opt.modeline = true -- let local buffers modify variables
vim.opt.undofile = true -- Save undo history
vim.opt.backspace = { 'indent', 'eol', 'start' } -- fixes backspace
vim.opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smartcase = true
vim.opt.number = false -- Should we show line numbers?
vim.opt.numberwidth = 4 -- What is the width of the line number column
vim.opt.signcolumn = 'yes:1' -- Always show sign column, and make it 1 character large
vim.opt.cindent = false -- Disables c-style indentation
vim.opt.smartindent = true -- Do smart auto-indent when starting a new line

-- Decrease update time - affects which-key.nvim plugin
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 600

-- Set completeopt to have a better completion experience
vim.opt.completeopt = 'menuone,noselect'

-- Toggle showing line numbers
vim.keymap.set(
    'n',
    '<c-n><c-n>',
    ':set invnumber<CR>',
    { desc = 'Toggle show line numbers' }
)

-- HTML editing does not need line breaking...
vim.api.nvim_create_autocmd(
    'FileType',
    { pattern = { 'html' }, command = [[set textwidth=0]] }
)

-- Do not expand tabs in Makefiles
vim.api.nvim_create_autocmd(
    'FileType',
    { pattern = { 'make' }, command = [[set noexpandtab]] }
)

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

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group =
    vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- use ;; for escape (iPad keyboard)
-- http://vim.wikia.com/wiki/Avoid_the_escape_key
-- vim.keymap.set('i', ';;', '<Esc>', { noremap = true })

vim.keymap.set('n', '<space>', function()
    vim.cmd.noh()
end, { desc = 'Disables highlighting' })

vim.keymap.set('n', '<leader>ie', '<cmd>edit $MYVIMRC<cr>', {
    desc = '[I]nit.lua (neovim) [E]dit',
    noremap = true,
    silent = true,
})

vim.keymap.set('n', '<leader>is', '<cmd>source $MYVIMRC<cr>', {
    desc = '[I]nit.lua (neovim) [S]ource (reload)',
    noremap = true,
    silent = true,
})
