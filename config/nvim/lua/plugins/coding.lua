return {

    -- auto-commenter for lines and code-blocks
    {
        'numToStr/Comment.nvim',
        opts = { opleader = { line = 'cc', block = 'cb' } },
    },

    -- Displays and trims trailing whitespaces
    {
        'kaplanz/nvim-retrail',
        config = function()
            local defaults = require('retrail.config.defaults')
            table.insert(defaults.filetype.exclude, 'dashboard')
            require('retrail').setup()
        end,
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

            require('ibl').setup({
                indent = { char = '┊' },
                whitespace = { highlight = { 'Whitespace', 'NonText' } },

                -- avoids this plugin to interact with these filetypes
                exclude = {
                    filetypes = {
                        'dashboard',
                        'lspinfo',
                        'packer',
                        'checkhealth',
                        'help',
                        'man',
                        'gitcommit',
                        'TelescopePrompt',
                        'TelescopeResults',
                        '',
                    },
                },
            })
        end,
    },

    {
        'nomnivore/ollama.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim',
        },

        -- All the user commands added by the plugin
        cmd = { 'Ollama', 'OllamaModel', 'OllamaServe', 'OllamaServeStop' },

        keys = {
            -- Note that the <c-u> is important for selections to work properly.

            -- Genernal selector menu.
            {
                '<leader>oo',
                ":<c-u>lua require('ollama').prompt()<cr>",
                desc = 'ollama: selector prompt',
                mode = { 'n', 'v' },
            },

            {
                '<leader>og',
                ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
                desc = 'ollama: generate code',
                mode = { 'n', 'v' },
            },

            {
                '<leader>os',
                ":<c-u>lua require('ollama').prompt('Simplify_Code')<cr>",
                desc = 'ollama: simplify code',
                mode = { 'n', 'v' },
            },

            {
                '<leader>oe',
                ":<c-u>lua require('ollama').prompt('Explain_Code')<cr>",
                desc = 'ollama: explain code',
                mode = { 'n', 'v' },
            },

        },

        ---@type Ollama.Config
        opts = {
            -- your configuration overrides
        },
    },
}
