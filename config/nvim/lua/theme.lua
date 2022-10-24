-- Color scheme/theme
vim.opt.termguicolors = true -- finer colors
vim.opt.background = "dark"

-- Nightfox configuration
local theme_to_use = 'duskfox'
vim.cmd('colorscheme ' .. theme_to_use)

-- Lualine configuration
require('lualine').setup({options={theme='auto'}})

-- Shows line numbers and make double-C-n switch modes
vim.opt.number = false
vim.opt.numberwidth = 4
vim.keymap.set('n', '<C-N><C-N>', ':set invnumber<CR>')

-- Set the signcolumn (gutter) and linenr to a darker variant of the current
-- background by using color darkening functions from nightfox
local palette = require('nightfox.palette').load(theme_to_use)
local Color = require("nightfox.lib.color")
local faded0 = Color.from_hex(palette.bg1):brighten(-10):to_css()
vim.cmd('highlight SignColumn guibg=' .. faded0)
local faded1 = Color.from_hex(palette.bg1):brighten(-5):to_css()
vim.cmd('highlight LineNr guibg=' .. faded1)

-- Reset CoC sign column symbols to use the right pallete colors for each of
-- the possible indications, and the right background as we set above
local spec = require('nightfox.spec').load(theme_to_use)
vim.cmd('highlight CocErrorSign guibg=' .. faded0 ..
        ' guifg=' .. spec.diag.error)
vim.cmd('highlight CocWarningSign guibg=' .. faded0 ..
        ' guifg=' .. spec.diag.warn)
vim.cmd('highlight CocInfoSign guibg=' .. faded0 ..
        ' guifg=' .. spec.diag.info)
vim.cmd('highlight CocHintSign guibg=' .. faded0 ..
        ' guifg=' .. spec.diag.hint)

-- Indent guides configuration
vim.g.indent_guides_guide_size = 1

-- Lets me manage the gutter color, always show the bar
vim.opt.signcolumn = 'yes'
vim.g.gitgutter_grep = ''
vim.g.gitgutter_set_sign_backgrounds = 1

-- show trailing whitespaces, handle it better
vim.cmd('highlight ExtraWhitespace guibg=' .. spec.diag.warn)
