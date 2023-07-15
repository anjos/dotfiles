-- Telescope action back to `find_files` if not inside a git repository
local project_files = function(opts)
    vim.fn.system('git rev-parse --is-inside-work-tree')
    if vim.v.shell_error == 0 then
        require('telescope.builtin').git_files(opts)
    else
        require('telescope.builtin').find_files(opts)
    end
end

-- Merges two lua tables, returns the first one
local merge_tables = function(t1, t2)
    for k, v in ipairs(t2) do
        table.insert(t1, v)
    end
    return t1
end

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
            local default_telescope_options = {
                layout_strategy = 'flex',
                layout_config = {
                    height = 0.9,
                    width = 0.9,
                    flip_columns = 150,
                    horizontal = {
                        preview_cutoff = 40,
                    },
                    vertical = {
                        preview_cutoff = 40,
                    },
                },
                winblend = 10,
            }

            local default_dropdown_options =
                require('telescope.themes').get_dropdown({
                    previewer = false,
                    winblend = 10,
                })

            -- opens file browser
            vim.keymap.set('n', '<leader>f.', function()
                require('telescope').extensions.file_browser.file_browser(
                    default_telescope_options
                )
            end, { desc = 'Open file browser', noremap = true })

            vim.keymap.set('n', '<leader>fp', function()
                require('telescope').extensions.file_browser.file_browser(
                    merge_tables(
                        { path = '%:p:h', select_buffer = true },
                        default_telescope_options
                    )
                )
            end, {
                desc = 'Open file browser on buffer parent dir',
                noremap = true,
            })

            vim.keymap.set('n', '<leader>!', function()
                require('telescope.builtin').oldfiles(default_telescope_options)
            end, { desc = 'Open recent file', noremap = true })

            for _, lhs in ipairs({ '<leader>k', '<leader>fk' }) do
                vim.keymap.set('n', lhs, function()
                    require('telescope.builtin').keymaps(
                        default_telescope_options
                    )
                end, { desc = 'Find keymaps', noremap = true })
            end

            for _, lhs in ipairs({ '<C-b>', '<leader>fz' }) do
                vim.keymap.set('n', lhs, function()
                    require('telescope.builtin').buffers(
                        default_telescope_options
                    )
                end, { desc = 'Find buffer', noremap = true })
            end

            for _, lhs in ipairs({ '<C-s>', '<leader>fr' }) do
                vim.keymap.set('n', lhs, function()
                    require('telescope.builtin').registers(
                        default_telescope_options
                    )
                end, { desc = 'Choose register', noremap = true })
            end

            vim.keymap.set('n', '<leader>/', function()
                require('telescope.builtin').current_buffer_fuzzy_find(
                    default_dropdown_options
                )
            end, {
                desc = 'Fuzzily search in current buffer',
                noremap = true,
            })

            vim.keymap.set('n', '<leader>fg', function()
                require('telescope.builtin').git_files(
                    default_telescope_options
                )
            end, {
                desc = 'Find files registered on git repository',
                noremap = true,
            })

            vim.keymap.set('n', '<leader>ff', function()
                require('telescope.builtin').find_files(
                    default_telescope_options
                )
            end, {
                desc = 'Find files recursively from current directory',
                noremap = true,
            })

            for _, lhs in ipairs({ '<C-a>', '<leader>fa' }) do
                vim.keymap.set('n', lhs, function()
                    project_files(default_telescope_options)
                end, {
                    desc = 'Find git files or files (non-git repos)',
                    noremap = true,
                })
            end

            vim.keymap.set('n', '<leader>fh', function()
                require('telescope.builtin').help_tags(
                    default_telescope_options
                )
            end, { desc = 'Find on help', noremap = true })

            vim.keymap.set('n', '<leader>fe', function()
                require('telescope.builtin').live_grep(
                    default_telescope_options
                )
            end, {
                desc = 'Find expression with grep',
                noremap = true,
            })

            vim.keymap.set('n', '<leader>fw', function()
                require('telescope.builtin').grep_string(
                    default_telescope_options
                )
            end, {
                desc = 'Find the current word with grep',
                noremap = true,
            })

            vim.keymap.set('n', '<leader>fd', function()
                require('telescope.builtin').diagnostics(
                    default_telescope_options
                )
            end, { desc = 'Find on diagnostics', noremap = true })
        end,
    },
}
