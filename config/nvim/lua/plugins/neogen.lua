return {
    {
        'danymat/neogen',
        config = function()
            local neogen = require('neogen')
            neogen.setup({
                snippet_engine = "luasnip",
                languages = {
                    python = {
                    template = {
                            annotation_convention = "numpydoc",
                        },
                    },
                },
            })

            -- keybindings
            vim.keymap.set(
                'n',
                '<Leader>gd',
                neogen.generate,
                {
                    noremap = true,
                    silent = true,
                    desc = 'Generate documentation for current object',
                }
            )

        end,
    },
}
