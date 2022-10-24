-- Color scheme/theme
vim.opt.termguicolors = true -- finer colors
vim.opt.bg = 'dark' -- use dark background on guis
vim.cmd('colorscheme hybrid')

-- Airline configuration
vim.opt.laststatus = 2
vim.g.airline_theme = 'wombat'
vim.g.airline_powerline_fonts = 1

vim.g['airline#extensions#branch#enabled'] = 1
vim.g['airline#extensions#branch#displayed_head_limit'] = 10
vim.g['airline#extensions#whitespace#enabled'] = 1

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
vim.cmd('highlight SignColumn ctermbg=232')
vim.cmd('highlight SignColumn guibg=#0f0f0f')

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
