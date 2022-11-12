-- Color scheme/theme
vim.opt.termguicolors = true -- finer colors
vim.opt.background = "dark"

-- Theme configuration
-- local theme_to_use = 'nordfox'
-- local theme_to_use = 'tokyonight'
local theme_to_use = 'tokyonight-night'
-- local theme_to_use = 'gruvbox'

-- Set the signcolumn (gutter) and linenr to a darker variant of the current
-- background by using color darkening functions from nightfox
local sign_column_color = "#000000"
local linenr_column_color = "#000000"
local error_sign_color = "#ff0000"
local warning_sign_color = "#ffff00"
local info_sign_color = "#00ff00"
local hint_sign_color = "#ff00ff"

if theme_to_use:sub(-#"fox") == "fox" then
    -- handle all sets of nightfox themes

    local palette = require('nightfox.palette').load(theme_to_use)
    local Color = require("nightfox.lib.color")

    sign_column_color = Color.from_hex(palette.bg1):brighten(-10):to_css()
    linenr_column_color = Color.from_hex(palette.bg1):brighten(-5):to_css()

    local spec = require('nightfox.spec').load(theme_to_use)
    error_sign_color = spec.diag.error
    warning_sign_color = spec.diag.warn
    info_sign_color = spec.diag.info
    hint_sign_color = spec.diag.hint

elseif theme_to_use:sub(1, #"tokyonight") == "tokyonight" then
    -- handles all sets of tokyonight theme details

    local colors = require('tokyonight.colors').setup()
    local util = require('tokyonight.util')

    sign_column_color = util.darken(colors.bg, 0.3, '#000000')
    linenr_column_color = util.darken(colors.bg, 0.5, '#000000')

    error_sign_color = colors.red
    warning_sign_color = colors.yellow
    info_sign_color = colors.green
    hint_sign_color = colors.magenta

elseif theme_to_use == "gruvbox" then

    local colors = require("gruvbox.palette")
    local util = require('tokyonight.util')

    sign_column_color = util.darken(colors.dark0, 0.3, '#000000')
    linenr_column_color = util.darken(colors.dark0, 0.5, '#000000')

    error_sign_color = colors.neutral_red
    warning_sign_color = colors.neutral_yellow
    info_sign_color = colors.neutral_green
    hint_sign_color = colors.neutral_purple

end

-- Shows line numbers and make double-C-n switch modes
vim.opt.number = false
vim.opt.numberwidth = 4
vim.keymap.set('n', '<C-N><C-N>', ':set invnumber<CR>')

-- Lualine configuration
require('lualine').setup({options={theme='auto'}})

vim.cmd('colorscheme ' .. theme_to_use)

-- Personalise colors for the sign-column and git signs
vim.cmd('highlight SignColumn guibg=' .. sign_column_color)
vim.cmd('highlight CocErrorSign' ..
        ' guibg=' .. sign_column_color ..
        ' guifg=' .. error_sign_color)
vim.cmd('highlight CocWarningSign' ..
        ' guibg=' .. sign_column_color ..
        ' guifg=' .. warning_sign_color)
vim.cmd('highlight CocInfoSign' ..
        ' guibg=' .. sign_column_color ..
        ' guifg=' .. info_sign_color)
vim.cmd('highlight CocHintSign' ..
        ' guibg=' .. sign_column_color ..
        ' guifg=' .. hint_sign_color)

-- Make the line-number column (between sign and file) mid-way
vim.cmd('highlight LineNr guibg=' .. linenr_column_color)

-- show trailing whitespaces, handle it better
vim.cmd('highlight ExtraWhitespace guibg=' .. warning_sign_color)

-- Indent guides configuration
vim.g.indent_guides_guide_size = 1

-- Lets me manage the gutter color, always show the bar
vim.opt.signcolumn = 'yes'
vim.g.gitgutter_grep = ''
vim.g.gitgutter_set_sign_backgrounds = 1
