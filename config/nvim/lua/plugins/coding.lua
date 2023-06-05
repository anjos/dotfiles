return {

    -- Cause all trailing whitespace characters to be removed automatically:
    -- 1) at every file save
    -- 2) if you push <leader>t
    {
        'cappyzawa/trim.nvim',
        config = function()
            require('trim').setup({})
            vim.keymap.set(
                'n',
                '<leader>t',
                function()
                    require('trim.trimmer').trim()
                end,
                {
                    buffer = true,
                    noremap = true,
                    desc = 'Trim trailing whitespace on buffer',
                }
            )
        end,
    },

    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },
}
