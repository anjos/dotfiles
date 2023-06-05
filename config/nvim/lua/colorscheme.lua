-- Set the colorscheme for the editor
vim.opt.termguicolors = true -- finer colors
vim.opt.background = 'dark'

-- Indent guides configuration
vim.g.indent_guides_guide_size = 1

-- Select colorscheme using the variable below. Everything else is automated.
-- The following colorschemes are currently supported.
--
-- See: https://github.com/EdenEast/nightfox.nvim
-- nightfox sub-themes: nightfox, nordfox, dayfox, dawnfox, duskfox, terafox or carbonfox

-- See: https://github.com/folke/tokyonight.nvim
-- tokyonight sub-themes: tokyonight, tokyonight-night,
-- tokyonight-storm, tokyonight-day, tokyonight-moon

-- See: https://github.com/ellisonleao/gruvbox.nvim
-- no subthemes for this one!

-- vim.cmd [[colorscheme tokyonight-night]]

-- See https://github.com/navarasu/onedark.nvim
-- onedark styles: dark, darker, cool, deep, warm, warmer, light
require('onedark').setup({style = 'warmer'})
vim.cmd [[colorscheme onedark]]
