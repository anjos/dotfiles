return {

    {
        'ntpeters/vim-better-whitespace',
        priority = 1000,
        lazy = false,
        config = function()
            vim.g.better_whitespace_enabled = 1
            vim.g.strip_whitespace_on_save = 1
            vim.g.strip_whitespace_confirm = 0

            -- binds new key mapping for removing whitespaces in buffer
            vim.keymap.set({ 'n' }, '<leader>t', function()
                vim.cmd('StripWhitespace')
            end, { desc = 'Strip whitespace on current buffer' })
        end,
    },

    -- "gc" to comment visual regions/lines
    {
        'numToStr/Comment.nvim',
        opts = { opleader = { line = 'cc', block = 'cb' } },
    },

}
