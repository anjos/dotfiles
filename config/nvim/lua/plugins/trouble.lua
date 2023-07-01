return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('trouble').setup({})

        vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', {
            noremap = true,
            silent = true,
            desc = 'Toggle trouble window (workspace)',
        })

        vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', {
            noremap = true,
            silent = true,
            desc = 'Toggle trouble window (document)',
        })

        vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>', {
            noremap = true,
            silent = true,
            desc = 'Toggle trouble window (quickfix)',
        })

        vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<cr>', {
            noremap = true,
            silent = true,
            desc = 'Toggle trouble window (loclist)',
        })

        vim.keymap.set('n', '<leader>xr', '<cmd>TroubleToggle lsp_references<cr>', {
            noremap = true,
            silent = true,
            desc = 'Toggle trouble window (LSP references)',
        })
    end,
}
