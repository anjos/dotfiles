--- Trims whitespaces from the begin and end of a string
-- @str The string to be trimmed
local trim = function(str)
    return string.gsub(str, '^%s*(.-)[\r\n%s]*$', '%1')
end

--- Returns a string containing the currently defined conda environment
-- @symbol If you set symbol, then it prefixes the string with a symbol
local conda_env = function(symbol)
    local value = trim(os.getenv('CONDA_DEFAULT_ENV') or '[not set]')
    return string.format('%s%s', symbol or '', value)
end

--- Returns a string containing the current python interpreter version
-- @symbol If you set symbol, then it prefixes the string with a symbol
local python_version = function(symbol)
    local value = trim(vim.fn.system({
        'python',
        '-c',
        'print(".".join(map(str, __import__("sys").version_info[:3])))',
    }))
    value = value or '[not set]'
    return string.format('%s%s', symbol or '', value)
end

--- Returns a string containing the name of the base directory
-- of the current git repository (if there is one), or an empty string
-- if we are not in a git repository
-- @symbol If you set the symbol, then it prefixes with that
local git_basedir = function(symbol)
    local value = vim.fs.basename(
        trim(vim.fn.system('git rev-parse --show-toplevel 2>/dev/null'))
    )
    if value ~= '' then
        return string.format('%s%s', symbol or '', value)
    end
    return nil
end

--- Returns a string containing the name of the base directory
-- of the current git repository (if there is one), or an empty string
-- if we are not in a git repository
-- @symbol If you set the symbol, then it prefixes with that
local basedir = function(symbol)
    local value = vim.fn.getcwd()
    if value == os.getenv('HOME') then
        value = '~'
    else
        value = vim.fs.basename(value)
    end
    return string.format('%s%s', symbol or '', value)
end

--- Returns a string containing the name of the current git branch (if there is
-- one), or an empty string
-- @symbol If you set the symbol, then it prefixes with that
local git_branch = function(symbol)
    local value = trim(vim.fn.system('git branch --show-current 2>/dev/null'))
    if value ~= '' then
        return string.format('%s%s', symbol or '', value)
    end
    return ''
end

--- Merges various strings with a separator, but only if they are not empty, in
-- which case they are discarded from the output
local merge_non_empty = function(strs, merge_symbol)
    local t = {}
    for _, value in ipairs(strs) do
        if value ~= '' then
            table.insert(t, value)
        end
    end
    return table.concat(t, merge_symbol)
end

-- Returns the current neovim version as a string
local neovim_version_string = function()
    local v = vim.version()
    return v.major .. '.' .. v.minor .. '.' .. v.patch
end

-- local neovim_spelled_out = {
--     '███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
--     '████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║',
--     '██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║',
--     '██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
--     '██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
--     '╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
-- }

local neovim_logo_short = {
    '     .          .     ',
    "   ';;,.        ::'   ",
    ' ,:::;,,        :ccc, ',
    ',::c::,,,,.     :cccc,',
    ',cccc:;;;;;.    cllll,',
    ',cccc;.;;;;;,   cllll;',
    ':cccc; .;;;;;;. coooo;',
    ";llll;   ,:::::'loooo;",
    ";llll:    ':::::loooo:",
    ':oooo:     .::::llodd:',
    '.;ooo:       ;cclooo:.',
    "  .;oc        'coo;.  ",
    "    .'         .,.    ",
}

-- local mario_head = {
--     '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
--     '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣶⣤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ',
--     '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢉⠉⠙⢿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀ ',
--     '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠎⢷⣄⠀⣿⣿⣿⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀ ',
--     '  ⠀⠀⠀⣠⣴⣶⣶⣤⣤⣄⣀⠀⠁⠠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠀⠀⠀⠀⠀ ',
--     '  ⠀⠀⠀⠙⠿⢿⣿⣿⣿⣿⣿⣿⣷⣦⣌⠙⠻⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀ ',
--     '  ⠀⠀⠀⠀⠀⠀⠈⠉⢻⣿⣿⣿⣿⣿⣿⣿⣦⣄⠀⠉⠙⢿⣿⣿⣿⢠⣤⣤⣄ ',
--     '  ⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡄⠀⠀⢹⣿⣿⣿⣿⣿⣿⣧',
--     '  ⢠⣾⣿⣿⣿⣶⣤⣀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⠈⠻⠿⠿⣿⣿⡿⠃',
--     '  ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠉⢹⣿⣟⠁⠀⠀⠀⢀⣴⣾⣿⣶⡍⠀⠀',
--     '  ⠘⠿⣿⣿⣿⣿⡿⠟⠋⠘⠛⠋⠁⠀⠀⢠⣿⡏⠀⠀⢀⣰⣿⣿⣿⣿⣿⡗⠀⠀',
--     '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⣿⡿⠁⠀⠀',
--     '  ⠀⠀⠀⠀⠀⠀⢀⠀⠀⠀⠀⣠⣤⣴⣿⣿⣿⣿⣿⣿⣿⠟⠉⠙⠋⠉⠀⠀⠀⠀',
--     '  ⠀⠀⠀⠀⠀⠀⠙⠛⠲⢶⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀',
--     '  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
-- }

local make_header = function()
    local header = neovim_logo_short
    local info = {
        '',
        os.date('%A, %d %B %Y - %H:%M:%S, %Z'),
        '',
        merge_non_empty({
            git_basedir('  ') or basedir('  '),
            git_branch(' '),
            conda_env('🅒  '),
            python_version('🐍 '),
        }, ' | '),
        '',
    }
    for _, v in ipairs(info) do
        table.insert(header, v)
    end
    return header
end

return {

    {
        'glepnir/dashboard-nvim',
        priority = 100,
        event = 'VimEnter',
        config = function()
            require('dashboard').setup({
                theme = 'hyper',
                config = {
                    header = make_header(),
                    shortcut = {
                        -- action can be a function type
                        {
                            desc = 'Open git files ',
                            key = 'g',
                            group = 'DiagnosticWarn',
                            action = function()
                                require('telescope.builtin').git_files({
                                    layout_strategy = 'flex',
                                    layout_config = {
                                        width = 0.9,
                                        height = 0.9,
                                    },
                                })
                            end,
                        },
                        {
                            desc = '|  Open files ',
                            key = 'f',
                            group = 'DiagnosticWarn',
                            action = function()
                                require('telescope.builtin').find_files({
                                    layout_strategy = 'flex',
                                    layout_config = {
                                        width = 0.9,
                                        height = 0.9,
                                    },
                                })
                            end,
                        },
                        {
                            desc = '|  Grep ',
                            key = 'x',
                            group = 'DiagnosticWarn',
                            action = 'Telescope live_grep',
                        },
                        {
                            desc = '|  Search help ',
                            key = 'h',
                            group = 'DiagnosticWarn',
                            action = 'Telescope help_tags',
                        },
                    },
                    project = {
                        enable = true,
                        limit = 5,
                        action = 'Telescope file_browser path=%:p:h select_buffer=true cwd=',
                    },
                    footer = {
                        ' ',
                        '💡 André Anjos (https://anjos.ai) '
                            .. ' '
                            .. os.date('%Y')
                            .. ' - Neovim v'
                            .. neovim_version_string(),
                    },
                },
            })
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    },
}
