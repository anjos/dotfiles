return {

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
