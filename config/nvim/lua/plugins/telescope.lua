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
            local actions = require('telescope.actions')
            require('telescope').setup({
                defaults = {
                    mappings = {
                        i = {
                            ['<C-u>'] = false,
                            ['<C-d>'] = false,
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                            ['<C-l>'] = actions.select_default,
                        },
                    },
                },
                extensions = {
                    file_browser = {
                        hijack_netrw = true,
                        hidden = true,
                    },
                },
            })
            require('telescope').load_extension('fzf')
            require('telescope').load_extension('file_browser')

            -- Now also add these keymaps that work nicely with Telescope

            -- opens file browser
            vim.keymap.set(
                'n',
                '<leader>fb',
                '<cmd>Telescope file_browser<cr>',
                { desc = 'Open file browser', noremap = true }
            )

            vim.keymap.set(
                'n',
                '<leader>fp',
                '<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>',
                {
                    desc = 'Open file browser on buffer parent dir',
                    noremap = true,
                }
            )

            vim.keymap.set('n', '<leader>!', function()
                require('telescope.builtin').oldfiles({
                    layout_strategy = 'horizontal',
                })
            end, { desc = 'Open recent file', noremap = true })

            for _, lhs in ipairs({'<leader>k', '<leader>fk'}) do
                vim.keymap.set('n', lhs, function()
                    require('telescope.builtin').keymaps({
                        layout_strategy = 'vertical',
                    })
                end, { desc = 'Find keymaps', noremap = true })
            end

            for _, lhs in ipairs({'<C-b>', '<leader>fz'}) do
                vim.keymap.set('n', lhs, function()
                    require('telescope.builtin').buffers({
                        layout_strategy = 'vertical',
                    })
                end, { desc = 'Find buffer', noremap = true })
            end

            for _, lhs in ipairs({'<C-s>', '<leader>fr'}) do
                vim.keymap.set('n', lhs, function()
                    require('telescope.builtin').registers({
                        layout_strategy = 'vertical',
                    })
                end, { desc = 'Choose register', noremap = true })
            end

            vim.keymap.set('n', '<leader>/', function()
                require('telescope.builtin').current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown({
                        winblend = 10,
                        previewer = false,
                    })
                )
            end, {
                desc = 'Fuzzily search in current buffer',
                noremap = true,
            })

            vim.keymap.set('n', '<leader>fg', function()
                require('telescope.builtin').git_files({
                    layout_strategy = 'vertical',
                })
            end, { desc = 'Find files registered on git repository', noremap = true })

            for _, lhs in ipairs({'<C-a>', '<leader>ff'}) do
                vim.keymap.set('n', lhs, function()
                    require('telescope.builtin').find_files({
                        layout_strategy = 'vertical',
                    })
                end, { desc = 'Find files', noremap = true })
            end

            vim.keymap.set(
                'n',
                '<leader>fh',
                '<cmd>Telescope help_tags<cr>',
                { desc = 'Find on help', noremap = true }
            )

            vim.keymap.set(
                'n',
                '<leader>fe',
                '<cmd>Telescope live_grep<cr>',
                { desc = 'Find expression with grep', noremap = true }
            )

            vim.keymap.set(
                'n',
                '<leader>fw',
                '<cmd>Telescope grep_string<cr>',
                { desc = 'Find the current word with grep', noremap = true }
            )

            vim.keymap.set(
                'n',
                '<leader>fd',
                '<cmd>Telescope diagnostics<cr>',
                { desc = 'Find on diagnostics', noremap = true }
            )
        end,
    },
}
