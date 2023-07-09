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
                '<leader>tf',
                '<cmd>Telescope file_browser<cr>',
                { desc = '[?] Open file browser', noremap = true }
            )

            vim.keymap.set(
                'n',
                '<leader>tp',
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

            vim.keymap.set('n', '<leader>k', function()
                require('telescope.builtin').keymaps({
                    layout_strategy = 'vertical',
                })
            end, { desc = 'Search keymaps', noremap = true })

            vim.keymap.set('n', '<leader>bt', function()
                require('telescope.builtin').buffers({
                    layout_strategy = 'vertical',
                })
            end, { desc = 'Choose buffer', noremap = true })

            vim.keymap.set('n', '<C-b>', function()
                require('telescope.builtin').buffers({
                    layout_strategy = 'vertical',
                })
            end, { desc = 'Choose buffer', noremap = true })

            vim.keymap.set('n', '<C-s>', function()
                require('telescope.builtin').registers({
                    layout_strategy = 'vertical',
                })
            end, { desc = 'Choose register', noremap = true })

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

            vim.keymap.set('n', '<leader>gf', function()
                require('telescope.builtin').git_files({
                    layout_strategy = 'vertical',
                })
            end, { desc = 'Search [g]it [f]iles', noremap = true })

            vim.keymap.set('n', '<c-a>', function()
                require('telescope.builtin').find_files({
                    layout_strategy = 'vertical',
                })
            end, { desc = '[S]earch [f]iles', noremap = true })

            vim.keymap.set('n', '<leader>sf', function()
                require('telescope.builtin').find_files({
                    layout_strategy = 'vertical',
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
