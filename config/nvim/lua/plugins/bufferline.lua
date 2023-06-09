return {

    {
        'romgrk/barbar.nvim',
        dependencies = {
            -- 'lewis6991/gitsigns.nvim', -- configured on 'ui' plugins
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        config = function()
            require('barbar').setup({
                auto_hide = true,
                icons = {
                    buffer_index = true,
                },
            })

            -- keymaps to easily access buffers
            vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPrevious<CR>', {
                noremap = true,
                silent = true,
                desc = 'Go to previous buffer',
            })
            vim.keymap.set('n', '<leader>bn', '<Cmd>BufferNext<CR>', {
                noremap = true,
                silent = true,
                desc = 'Go to next buffer',
            })
            vim.keymap.set('n', '<leader>bw', '<Cmd>BufferClose<CR>', {
                noremap = true,
                silent = true,
                desc = 'Close buffer',
            })
            for j = 1, 9, 1 do
                vim.keymap.set(
                    'n',
                    string.format('<leader>b%d', j),
                    string.format('<Cmd>BufferGoto %d<CR>', j),
                    {
                        noremap = true,
                        silent = true,
                        desc = string.format('Go to buffer #%d', j),
                    }
                )
            end
            vim.keymap.set('n', '<leader>b$', '<Cmd>BufferLast<CR>', {
                noremap = true,
                silent = true,
                desc = 'Go to last buffer',
            })
        end,
    },
}
