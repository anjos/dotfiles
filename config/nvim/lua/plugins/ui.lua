-- Define a function to check the status and return the corresponding icon
local function get_ollama_status_icon()
    local loaded = package.loaded['ollama']

    if loaded == nil then
        return '󱙻 '
    end

    local status = require('ollama').status()
    local config = require('ollama').config

    if status == 'IDLE' then
        return '󱙺 ' .. config.model -- nf-md-robot-outline
    elseif status == 'WORKING' then
        return '󰚩 ' .. config.model -- nf-md-robot
    end
end

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
                -- displays filtetype icon and filename
                lualine_c = {
                    {
                        'filetype',
                        icon_only = true,
                    },
                    'filename',
                },
                lualine_x = {
                    -- 'encoding',
                    get_ollama_status_icon,
                    {
                        require('lazy.status').updates,
                        cond = require('lazy.status').has_updates,
                        color = { fg = 'ff9e64' },
                    },
                },
            },
        },
        dependencies = { 'nvim-tree/nvim-web-devicons' },
    },

    {
        -- Adds git related signs to the gutter, as well as utilities for managing changes
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

    -- {
    --     -- Adds a "noice" pop-up windows for notification and oneliners
    --     'folke/noice.nvim',
    --     event = 'VeryLazy',
    --     opts = {
    --         lsp = {
    --             -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    --             override = {
    --                 ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
    --                 ['vim.lsp.util.stylize_markdown'] = true,
    --                 ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
    --             },
    --         },
    --         -- you can enable a preset for easier configuration
    --         presets = {
    --             bottom_search = false, -- use a classic bottom cmdline for search
    --             command_palette = false, -- position the cmdline and popupmenu together
    --             long_message_to_split = true, -- long messages will be sent to a split
    --             inc_rename = false, -- enables an input dialog for inc-rename.nvim
    --             lsp_doc_border = false, -- add a border to hover docs and signature help
    --         },
    --         views = {
    --             cmdline_popup = {
    --                 size = {
    --                     width = '85%',
    --                 },
    --                 win_options = {
    --                     winblend = 10,
    --                     winhighlight = {
    --                         Normal = 'NoiceCmdlinePopupTitle',
    --                         FloatTitle = 'NoiceCmdlinePopupTitle',
    --                         FloatBorder = 'NoiceCmdlinePopupBorder',
    --                     },
    --                 },
    --             },
    --         },
    --     },
    --     dependencies = {
    --         'MunifTanjim/nui.nvim',
    --         'rcarriga/nvim-notify',
    --     },
    -- },
}
