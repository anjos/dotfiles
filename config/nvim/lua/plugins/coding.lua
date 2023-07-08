return {

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
                '<Leader>tt',
                require('trim.trimmer').trim,
                { desc = '[T]rim [t]railing whitespaces on buffer' }
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
        config = function()
            vim.opt.termguicolors = true

            -- These will make spaces and returns be shown:
            -- vim.opt.list = true
            -- vim.opt.listchars:append "space:⋅"
            -- vim.opt.listchars:append "eol:↴"

            require('indent_blankline').setup({
                char = '┊',
                space_char_blankline = ' ',
                show_trailing_blankline_indent = false,
                show_end_of_line = true,
                -- requires tree-sitter plugin
                -- depending on theme, this may not be highlighted properly
                -- works with tokyonight themes OK!
                show_current_context = true,
                show_current_context_start = true,

                -- avoids this plugin to interact with these filetypes
                filetype_exclude = {
                    "lspinfo",
                    "packer",
                    "checkhealth",
                    "help",
                    "man",
                    "dashboard",
                    "",
                },
            })

            table.insert(vim.g.indent_blankline_filetype_exclude, 'dashboard')
        end,
    },
}
