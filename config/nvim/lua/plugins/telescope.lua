return {
    -- Fuzzy Finder (files, lsp, etc)
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                -- Fuzzy Finder Algorithm which requires local dependencies to be built.
                -- Only load if `make` is available. Make sure you have the system
                -- requirements installed.
                'nvim-telescope/telescope-fzf-native.nvim',
                -- NOTE: If you are having trouble with this installation,
                --       refer to the README for telescope-fzf-native for more instructions.
                build = 'make',
                cond = function()
                    return vim.fn.executable('make') == 1
                end,
            },
            {
                -- A file browser extension for telescope.nvim
                'nvim-telescope/telescope-file-browser.nvim',
            },
        },
        config = function()
            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                        },
                    },
                },
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                    },
                },
            })
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('file_browser')

            -- Now also add these keymaps that work nicely with Telescope

            -- opens file browser
            vim.keymap.set(
                'n',
                '<leader>zz',
                '<cmd>Telescope file_browser<cr>',
                { desc = '[?] Open file browser', noremap = true }
            )

            vim.keymap.set(
                'n',
                '<leader>zz',
                '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>',
                {
                    desc = '[?] Open file browser on buffer parent dir',
                    noremap = true,
                }
            )

            vim.keymap.set(
                'n',
                '<leader>?',
                '<cmd>Telescope oldfiles<cr>',
                { desc = '[?] Open recent file', noremap = true }
            )

            vim.keymap.set(
                'n',
                '<leader><space>',
                '<cmd>Telescope buffers<cr>',
                { desc = '[<space>] Open recent buffer', noremap = true }
            )

            -- You can pass additional configuration to telescope to change theme, layout, etc.
            vim.keymap.set(
                'n',
                '<leader>/',
                function()
                    require('telescope.builtin').current_buffer_fuzzy_find(
                        require('telescope.themes').get_dropdown({
                            winblend = 10,
                            previewer = false,
                        })
                    )
                end,
                { desc = '[/] Fuzzily search in current buffer', noremap = true }
            )

            vim.keymap.set('n', '<leader>gf', function()
                require('telescope.builtin').git_files({
                    layout_strategy = 'vertical',
                    layout_config = { width = 0.9, height = 0.9 },
                })
            end, { desc = 'Search [g]it [f]iles', noremap = true })

            vim.keymap.set('n', '<c-a>', function()
                require('telescope.builtin').find_files({
                    layout_strategy = 'vertical',
                    layout_config = { width = 0.9, height = 0.9 },
                })
            end, { desc = '[S]earch [f]iles', noremap = true })

            vim.keymap.set('n', '<leader>sf', function()
                require('telescope.builtin').find_files({
                    layout_strategy = 'vertical',
                    layout_config = { width = 0.9, height = 0.9 },
                })
            end, { desc = '[S]earch [f]iles', noremap = true })

            vim.keymap.set(
                'n',
                '<leader>sh',
                '<cmd>Telescope help_tags<cr>',
                { desc = '[S]earch [h]elp', noremap = true }
            )

            vim.keymap.set(
                'n',
                '<leader>sg',
                '<cmd>Telescope live_grep<cr>',
                { desc = '[S]earch with [g]rep', noremap = true }
            )

            vim.keymap.set(
                'n',
                '<leader>sw',
                '<cmd>Telescope grep_string<cr>',
                { desc = '[S]earch current [w]ord with grep', noremap = true }
            )

            vim.keymap.set(
                'n',
                '<leader>sd',
                '<cmd>Telescope diagnostics<cr>',
                { desc = '[S]earch [d]iagnostics', noremap = true }
            )
        end,
    },
}
