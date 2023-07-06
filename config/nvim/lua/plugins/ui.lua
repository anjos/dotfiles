return {

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {} },

    {
        -- Set lualine as statusline
        'nvim-lualine/lualine.nvim',
        -- See `:help lualine.txt`
        opts = {
            options = {
                icons_enabled = true,
                theme = 'auto',
                component_separators = '|',
                section_separators = '',
            },
            sections = {
                lualine_x = {
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = { fg = "ff9e64" },
                    },
                },
            },
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    {
        -- Adds git releated signs to the gutter, as well as utilities for managing changes
        'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
            on_attach = function(bufnr)
                vim.keymap.set(
                    'n',
                    '[c',
                    require('gitsigns').prev_hunk,
                    { buffer = bufnr, desc = 'Go to Previous Hunk' }
                )
                vim.keymap.set(
                    'n',
                    ']c',
                    require('gitsigns').next_hunk,
                    { buffer = bufnr, desc = 'Go to Next Hunk' }
                )
                vim.keymap.set(
                    'n',
                    '<leader>ph',
                    require('gitsigns').preview_hunk,
                    { buffer = bufnr, desc = '[P]review [H]unk' }
                )
            end,
        },
    },

}
