-- Ensures a given package is installed through Mason
local mason_ensure_installed = function(pkg_names)
    local registry = require('mason-registry')
    for _, pkg_name in ipairs(pkg_names) do
        if not registry.is_installed(pkg_name) then
            vim.cmd('MasonInstall ' .. pkg_name)
        end
    end
end

return {

    {
        -- A format runner for Neovim.
        -- https://github.com/mhartington/formatter.nvim
        'mhartington/formatter.nvim',
        dependencies = {
            {
                'williamboman/mason.nvim',
                config = function()
                    require('mason').setup()
                end,
                build = ':MasonUpdate',
            },
        },
        config = function()
            mason_ensure_installed({
                'stylua',
                'isort',
                'docformatter',
                'black',
                'latexindent',
                'prettier',
                'taplo',
                'shfmt',
            })
            require('formatter').setup({
                -- We configure here the formatters we want applied, their
                -- behaviour (which just copies from formatter.nvim defaults in
                -- most cases), and any specific actions.
                log_level = vim.log.levels.WARN,
                filetype = {
                    lua = {
                        -- https://mason-registry.dev/registry/list#stylua
                        require('formatter.filetypes.lua').stylua,
                    },
                    python = {
                        -- https://mason-registry.dev/registry/list#isort
                        require('formatter.filetypes.python').isort,
                        -- https://mason-registry.dev/registry/list#docformatter
                        require('formatter.filetypes.python').docformatter,
                        -- https://mason-registry.dev/registry/list#black
                        require('formatter.filetypes.python').black,
                    },
                    tex = {
                        -- https://mason-registry.dev/registry/list#latexindent
                        function()
                            return {
                                exe = vim.fn.exepath("latexindent.pl") or vim.fn.exepath("latexindent") or "latexindent",
                                args = {
                                    "--local",
                                    "--modifylinebreaks",
                                    "--logfile=/dev/null",
                                },
                                stdin = true,
                            }
                        end
                    },
                    markdown = {
                        -- https://mason-registry.dev/registry/list#prettier
                        require('formatter.filetypes.markdown').prettier,
                    },
                    json = {
                        -- https://mason-registry.dev/registry/list#prettier
                        require('formatter.filetypes.json').prettier,
                    },
                    toml = {
                        -- https://mason-registry.dev/registry/list#taplo
                        require('formatter.filetypes.toml').taplo,
                    },
                    sh = {
                        -- https://mason-registry.dev/registry/list#shfmt
                        require('formatter.filetypes.sh').shfmt,
                    },
                    -- Use the special "*" filetype for defining formatter configurations on
                    -- any filetype
                    ['*'] = {
                        -- "formatter.filetypes.any" defines default configurations for any
                        -- filetype
                        require('formatter.filetypes.any').remove_trailing_whitespace,
                    },
                },
            })

            -- Hook autoformatting to various actions
            vim.keymap.set('n', '<leader>fb', function()
                vim.cmd("FormatLock")
            end, { noremap = true, desc = 'Re-format buffer' })

        end

    },

}
