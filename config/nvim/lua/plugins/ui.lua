-- Define a function to check the status and return the corresponding icon
local function get_ollama_status_icon()
    local loaded = package.loaded["ollama"]

    if loaded == nil then
        return "󱙻 "
    end

    local status = require("ollama").status()
    local config = require("ollama").config

    if status == "IDLE" then
        return "󱙺 " .. config.model  -- nf-md-robot-outline
    elseif status == "WORKING" then
        return "󰚩 " .. config.model  -- nf-md-robot
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
