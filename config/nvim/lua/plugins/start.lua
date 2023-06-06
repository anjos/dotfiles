return {

    {
        'glepnir/dashboard-nvim',
        priority = 100,
        event = 'VimEnter',
        config = function()
            require('dashboard').setup({
                config = {
                    header = {
                        '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
                        '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
                        '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⠉⠙⢿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀ ',
                        '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠎⢷⣄⠀⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀ ',
                        '  ⠀⠀⠀⣠⣴⣶⣶⣤⣤⣄⣀⠀⠁⠠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀ ',
                        '  ⠀⠀⠀⠙⠿⢿⣿⣿⣿⣿⣿⣿⣷⣦⣌⠙⠻⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀ ',
                        '  ⠀⠀⠀⠀⠀⠀⠈⠉⢻⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠉⠙⢿⣿⣿⣿⢠⣤⣤⣄ ',
                        '  ⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⢹⣿⣿⣿⣿⣿⣿⣧',
                        '  ⢠⣾⣿⣿⣿⣶⣤⣀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠈⠻⠿⠿⣿⣿⡿⠃',
                        '  ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠉⢹⣿⣟⠁⠀⠀⠀⢀⣴⣾⣿⣶⡍⠀⠀',
                        '  ⠘⠿⣿⣿⣿⣿⡿⠟⠋⠘⠛⠋⠁⠀⠀⢠⣿⡏⠀⠀⢀⣰⣿⣿⣿⣿⣿⡗⠀⠀',
                        '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀',
                        '  ⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⣠⣤⣴⣿⣿⣿⣿⣿⣿⣿⠟⠉⠙⠋⠉⠀⠀⠀⠀',
                        '  ⠀⠀⠀⠀⠀⠀⠙⠛⠲⢶⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                        '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
                        '                                ',
                        os.date('%A, %d %B %Y - %H:%M:%S, %Z'),
                        '                                ',
                    },
                    shortcut = {
                        -- action can be a function type
                        {
                            desc = 'Open git files ',
                            key = 'g',
                            group = 'DiagnosticWarn',
                            action = function()
                                require('telescope.builtin').git_files({
                                    layout_strategy = 'flex',
                                    layout_config = { width = 0.9, height = 0.9 },
                                }) end,
                        },
                        {
                            desc = '| Open files ',
                            key = 'f',
                            group = 'DiagnosticWarn',
                            action = function()
                                require('telescope.builtin').find_files({
                                    layout_strategy = 'flex',
                                    layout_config = { width = 0.9, height = 0.9 },
                                }) end,
                        },
                        {
                            desc = '| Grep ',
                            key = 'x',
                            group = 'DiagnosticWarn',
                            action = 'Telescope live_grep',
                        },
                        {
                            desc = '| Search help ',
                            key = 'h',
                            group = 'DiagnosticWarn',
                            action = 'Telescope help_tags',
                        },
                    },
                    project = {
                        enable = true,
                        limit = 5,
                        action = 'Telescope find_files cwd=',
                    },
                    footer = {
                        ' ',
                        '💡 André Anjos (https://anjos.ai)',
                        ' ',
                        ' ' .. os.date("%Y"),
                    }
                },
            })
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    },
}
