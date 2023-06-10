-- This function patches highlight groups so they are in better accordance
-- with the selected theme
--
local set_highlight_groups = function(background, severity)
    -- Personalise colors for the sign-column and git signs
    vim.api.nvim_set_hl(0, 'SignColumn', { bg = background['sign'] })
    local sign_column_theme = {
        Add = severity['info'],
        Change = severity['warning'],
        Delete = severity['error'],
    }
    for type, color in pairs(sign_column_theme) do
        local hl = 'GitSigns' .. type
        vim.api.nvim_set_hl(0, hl, { bg = background['sign'], fg = color })
    end

    -- Set LSP diagnostics gutter appearance
    local diagnostics_theme = {
        Error = { severity['error'], '' },
        Warn = { severity['warning'], '' },
        Info = { severity['info'], '󰋽' },
        Hint = { severity['hint'], '󰔷' },
    }
    for type, data in pairs(diagnostics_theme) do
        local hl = 'DiagnosticSign' .. type
        vim.api.nvim_set_hl(0, hl, { bg = background['sign'], fg = data[1] })
        vim.fn.sign_define(hl, { text = data[2], texthl = hl, numhl = hl })
    end

    -- Make the line-number column (between sign and file) mid-way
    vim.api.nvim_set_hl(0, 'LineNr', { bg = background['linenr'] })

    -- show trailing whitespaces, handle it better
    vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = severity['warning'] })
end

--- Overrides a specific attribute of a highlight
-- @ns_id Set highlight for namespace ns_id nvim_get_namespaces(). Use 0 to
--        get global highlight groups :highlight.
-- @name The name of the highlight
-- @opts The values of the highlight to override
-- local function mod_hl(ns_id, name, opts)
--     local is_ok, hl_def = pcall(vim.api.nvim_get_hl, ns_id, { name = name })
--     if is_ok then
--         for k, v in pairs(opts) do
--             hl_def[k] = v
--         end
--         vim.api.nvim_set_hl(0, name, hl_def)
--     end
-- end

return {
    -- Colorschemes we can switch to
    {
        'folke/tokyonight.nvim',
        branch = 'main',
        lazy = true, -- this plugin will be loaded on "colorscheme tokyonight"
        priority = 1000,
        config = function()
            require('tokyonight').setup()
            -- setup callback in case this colorscheme is set
            vim.api.nvim_create_autocmd('ColorScheme', {
                pattern = 'tokyonight*',
                callback = function(event)
                    local colors = require('tokyonight.colors').setup()
                    local util = require('tokyonight.util')
                    set_highlight_groups({
                        sign = util.darken(colors.bg, 0.4, '#000000'),
                        linenr = util.darken(colors.bg, 0.7, '#000000'),
                    }, {
                        error = colors.red,
                        warning = colors.yellow,
                        info = colors.green,
                        hint = colors.magenta,
                    })
                end,
            })
        end,
    },

    {
        'EdenEast/nightfox.nvim',
        lazy = true, -- this plugin will be loaded on "colorscheme nightfox"
        priority = 1000,
        config = function()
            require('nightfox').setup()
            -- setup callback in case this colorscheme is set
            vim.api.nvim_create_autocmd('ColorScheme', {
                pattern = '*fox',
                callback = function(event)
                    local color = require('nightfox.lib.color')
                    local palette =
                        require('nightfox.palette').load(event['match'])
                    local spec = require('nightfox.spec').load(event['match'])
                    set_highlight_groups({
                        sign = color
                            .from_hex(palette.bg1)
                            :brighten(-10)
                            :to_css(),
                        linenr = color
                            .from_hex(palette.bg1)
                            :brighten(-5)
                            :to_css(),
                    }, {
                        error = spec.diag.error,
                        warning = spec.diag.warn,
                        info = spec.diag.info,
                        hint = spec.diag.hint,
                    })
                end,
            })
        end,
    },

    {
        'ellisonleao/gruvbox.nvim',
        lazy = true, -- this plugin will be loaded on "colorscheme gruvbox"
        priority = 1000,
        dependencies = { 'folke/tokyonight.nvim' },
        config = function()
            -- setup callback in case this colorscheme is set
            vim.api.nvim_create_autocmd('ColorScheme', {
                pattern = 'gruvbox',
                callback = function(event)
                    require('gruvbox').setup()
                    local colors = require('gruvbox.palette').colors
                    local util = require('tokyonight.util')
                    set_highlight_groups({
                        sign = util.darken(colors.dark0, 0.4, '#000000'),
                        linenr = util.darken(colors.dark0, 0.7, '#000000'),
                    }, {
                        error = colors.neutral_red,
                        warning = colors.neutral_yellow,
                        info = colors.neutral_green,
                        hint = colors.neutral_purple,
                    })
                end,
            })
        end,
    },

    {
        'navarasu/onedark.nvim',
        lazy = true, -- this plugin will be loaded on "colorscheme gruvbox"
        priority = 1000,
        dependencies = { 'folke/tokyonight.nvim' },
        config = function()
            -- setup callback in case this colorscheme is set
            vim.api.nvim_create_autocmd('ColorScheme', {
                pattern = 'onedark',
                callback = function()
                    local colors =
                        require('onedark.palette')[vim.g.onedark_config.style]
                    local util = require('tokyonight.util')
                    set_highlight_groups({
                        sign = util.darken(colors.bg0, 0.4, '#000000'),
                        linenr = util.darken(colors.bg0, 0.7, '#000000'),
                    }, {
                        error = colors.red,
                        warning = colors.yellow,
                        info = colors.green,
                        hint = colors.purple,
                    })

                    -- run some adjustments for barbar plugin
                    -- mod_hl(0, 'BufferDefaultCurrentIndex', { bg = '#a0a8b7' })
                    -- mod_hl(
                    --     0,
                    --     'BufferDefaultVisible',
                    --     { bg = util.darken(colors.bg0, 0.4, '#000000') }
                    -- )
                end,
            })
        end,
    },
}
