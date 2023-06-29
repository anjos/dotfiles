return {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        require('trouble').setup({})

        vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', {
            noremap = true,
            silent = true,
            desc = '[T]oggle [T]rouble window',
        })
    end,
}
