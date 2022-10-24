-- Color scheme/theme
vim.opt.termguicolors = true -- finer colors
vim.opt.background = "dark"

-- Nightfox configuration
vim.cmd[[colorscheme nightfox]]

-- Lualine configuration
require('lualine').setup({options={theme='auto'}})

-- Shows line numbers and make double-C-n switch modes
vim.opt.number = false
vim.opt.numberwidth = 4
vim.keymap.set('n', '<C-N><C-N>', ':set invnumber<CR>')

-- Indent guides configuration
vim.g.indent_guides_guide_size = 1

-- Lets me manage the gutter color, always show the bar
vim.g.gitgutter_grep = ''
vim.g.gitgutter_override_sign_column_highlight = 0
vim.opt.signcolumn = 'yes'

-- show trailing whitespaces
vim.cmd('highlight ExtraWhitespace ctermbg=red guibg=red')

vim.api.nvim_create_autocmd("ColorScheme",
  { pattern = { "*" }, command = [[highlight ExtraWhitespace guibg=red]] }
)

vim.api.nvim_create_autocmd("BufEnter",
  { pattern = { "*" }, command = [[match ExtraWhitespace /\s\+$/]] }
)

vim.api.nvim_create_autocmd("InsertEnter",
  { pattern = { "*" }, command = [[match ExtraWhitespace /\s\+\%#\@<!$/]] }
)

vim.api.nvim_create_autocmd("InsertLeave",
  { pattern = { "*" }, command = [[match ExtraWhiteSpace /\s\+$/]] }
)
