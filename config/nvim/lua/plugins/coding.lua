return {

    -- {
    --     'ntpeters/vim-better-whitespace',
    --     priority = 1000,
    --     lazy = false,
    --     config = function()
    --         vim.g.better_whitespace_enabled = 1
    --         vim.g.strip_whitespace_on_save = 1
    --         vim.g.strip_whitespace_confirm = 0
    --         -- binds new key mapping for removing whitespaces in buffer
    --         vim.keymap.set({ 'n' }, '<leader>t', function()
    --             vim.cmd('StripWhitespace')
    --         end, { desc = 'Strip whitespace on current buffer' })
    --         vim.g.better_whitespace_filetypes_blacklist = {
    --             'dashboard',
    --         }
    --     end,
    -- },

    {
        'cappyzawa/trim.nvim',
        config = function()
            require('trim').setup({
                ft_blocklist = {
                    'TelescopePrompt',
                    'Trouble',
                    'help',
                    'dashboard',
                },
                -- if you want to remove multiple blank lines
                -- replace multiple blank lines with a single line
                -- patterns = {
                --     [[%s/\(\n\n\)\n\+/\1/]],
                -- },
                --
                -- trim_on_write = true,
                -- trim_trailing = true,
                -- trim_last_line = true,
                -- trim_first_line = true,
            })

            -- remove trailing whitespace with a keybinding
            vim.keymap.set(
                'n',
                '<Leader>t',
                require('trim.trimmer').trim,
                { desc = 'Trim training whitespaces on buffer' }
            )
        end,
    },

    -- auto-commenter for lines and code-blocks
    {
        'numToStr/Comment.nvim',
        opts = { opleader = { line = 'cc', block = 'cb' } },
    },

    {
        -- Add indentation guides even on blank lines
        -- See `:help indent_blankline.txt`
        'lukas-reineke/indent-blankline.nvim',
        config = function ()
            vim.opt.termguicolors = true
            -- vim.opt.list = true
            -- vim.opt.listchars:append "space:⋅"
            -- vim.opt.listchars:append "eol:↴"
            require("indent_blankline").setup({
                char = '┊',
                space_char_blankline = " ",
                show_trailing_blankline_indent = false,
                show_current_context = true,
                show_current_context_start = true,
                show_end_of_line = true,
            })
        end,
    },

}
