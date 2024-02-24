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
                lazy = true,
            },
        },
        config = function()
            -- mininum amount of Mason plugins we install
            local install_table = {
                'bash-language-server',
                'black',
                'css-lsp',
                'docformatter',
                'dockerfile-language-server',
                'dot-language-server',
                'esbonio',
                'html-lsp',
                'isort',
                'json-lsp',
                'lua-language-server',
                'luacheck',
                'markdownlint',
                'prettier',
                'pydocstyle',
                'pyright',
                'rstcheck',
                'ruff',
                'ruff-lsp',
                'shfmt',
                'stylua',
                'taplo',
                'texlab',
                'yaml-language-server',
                'yamllint',
            }

            -- this Mason plugin is not supported on the raspberry pi
            local arch = io.popen('uname -m'):read('*a'):match('%w+'):lower()
            if arch ~= 'aarch64' then
                table.insert(install_table, 'latexindent')
            end

            -- Function to handle request and respond with specific format
            function handleRequest(request)
                local response = {
                    header = { ['Content-Type'] = 'application/json' },
                    body = {},
                }

                -- Your logic here to process the request and build the response body
                table.insert(response.body, { 'key1', 'value1' })
                table.insert(response.body, { 'key2', 'value2' })

                return response
            end

            mason_ensure_installed(install_table)
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
                                exe = vim.fn.exepath('latexindent.pl')
                                    or vim.fn.exepath('latexindent')
                                    or 'latexindent',
                                args = {
                                    '--local',
                                    '--modifylinebreaks',
                                    '--logfile=/dev/null',
                                },
                                stdin = true,
                            }
                        end,
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
                vim.cmd('FormatLock')
            end, { noremap = true, desc = 'Re-format buffer' })
        end,
    },
}
