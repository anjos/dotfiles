return {

    -- NOTE: This is where your plugins related to LSP can be installed.
    --  The configuration is done below. Search for lspconfig to find it below.
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Automatically install LSPs to stdpath for neovim
            {
                'williamboman/mason.nvim',
                config = true,
                build = ':MasonUpdate',
            },
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            { 'j-hui/fidget.nvim', branch = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            { 'folke/neodev.nvim', opts = {} },
        },
        config = function()
            --  This function gets run when an LSP connects to a particular buffer.
            local on_attach_common = function(_, bufnr)
                vim.keymap.set(
                    'n',
                    '<leader>rn',
                    vim.lsp.buf.rename,
                    { buffer = bufnr, desc = '[R]e[n]ame Buffer' }
                )

                vim.keymap.set(
                    'n',
                    '<leader>ca',
                    vim.lsp.buf.code_action,
                    { buffer = bufnr, desc = '[C]ode [A]ction' }
                )

                vim.keymap.set(
                    'n',
                    'gd',
                    vim.lsp.buf.definition,
                    { buffer = bufnr, desc = '[G]oto [D]efinition' }
                )

                vim.keymap.set(
                    'n',
                    'gr',
                    require('telescope.builtin').lsp_references,
                    { buffer = bufnr, desc = '[G]oto [R]eferences' }
                )

                vim.keymap.set(
                    'n',
                    'gI',
                    vim.lsp.buf.implementation,
                    { buffer = bufnr, desc = '[G]oto [I]mplementation' }
                )

                vim.keymap.set(
                    'n',
                    '<leader>D',
                    vim.lsp.buf.type_definition,
                    { buffer = bufnr, desc = 'Type [D]efinition' }
                )

                vim.keymap.set(
                    'n',
                    '<leader>ds',
                    require('telescope.builtin').lsp_document_symbols,
                    { buffer = bufnr, desc = '[D]ocument [S]ymbols' }
                )

                vim.keymap.set(
                    'n',
                    '<leader>ws',
                    require('telescope.builtin').lsp_dynamic_workspace_symbols,
                    { buffer = bufnr, desc = '[W]orkspace [S]ymbols' }
                )

                -- See `:help K` for why this keymap
                vim.keymap.set(
                    'n',
                    'K',
                    vim.lsp.buf.hover,
                    { buffer = bufnr, desc = 'Hover Documentation' }
                )

                vim.keymap.set(
                    'n',
                    '<C-k>',
                    vim.lsp.buf.signature_help,
                    { buffer = bufnr, desc = 'Signature Documentation' }
                )

                -- Lesser used LSP functionality
                vim.keymap.set(
                    'n',
                    'gD',
                    vim.lsp.buf.declaration,
                    { buffer = bufnr, desc = '[G]oto [D]eclaration' }
                )

                vim.keymap.set(
                    'n',
                    '<leader>wa',
                    vim.lsp.buf.add_workspace_folder,
                    { buffer = bufnr, desc = '[W]orkspace [A]dd Folder' }
                )

                vim.keymap.set(
                    'n',
                    '<leader>wr',
                    vim.lsp.buf.remove_workspace_folder,
                    { buffer = bufnr, desc = '[W]orkspace [R]emove Folder' }
                )

                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, {
                    buffer = bufnr,
                    desc = '[W]orkspace [L]ist Folders',
                })

                -- Creates a command `:Format` local to the LSP buffer
                vim.api.nvim_buf_create_user_command(
                    bufnr,
                    'Format',
                    function(_)
                        vim.lsp.buf.format()
                    end,
                    { desc = 'Format current buffer with LSP' }
                )
            end

            local on_attach_specific = {
                ruff_lsp = function(client, _)
                    -- defers some capabilities on python LSP to pyright
                    client.server_capabilities.hoverProvider = false
                end,
                yamlls = function(_, bufnr)
                    -- if the buffer name matches `meta.yml`, disables
                    -- diagnostics as this is a jinja2 template that is badly
                    -- named...
                    local filename = 'meta.yaml'
                    if
                        vim.api
                            .nvim_buf_get_name(bufnr)
                            :sub(-string.len(filename))
                        == filename
                    then
                        vim.diagnostic.disable(bufnr)
                    end
                end,
            }

            -- Enables the following language servers via mason
            --
            -- Add any additional override configuration in the following tables.
            -- They will be passed to the `settings` field of the server config.
            -- You must look up that documentation yourself.
            local servers = {
                -- Keep this to edit neovim configuration written in lua
                lua_ls = {
                    Lua = {
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
                pyright = {
                    python = {},
                },
                ruff_lsp = {},
                bashls = {},
                jsonls = {},
                cssls = {},
                texlab = {},
                dotls = {},
                dockerls = {},
                html = {},
                esbonio = {},
                yamlls = {},
                taplo = {},
            }

            local before_init = {
                pyright = function(_, config)
                    -- Changes the Python path when the server is started
                    config.settings.python.pythonPath = exepath('python3')
                        or exepath('python')
                end,
            }

            local filetypes = {
                texlab = { 'tex', 'bib' },
                esbonio = { 'rst' },
            }

            -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities =
                require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- Ensure the servers above are installed
            local mason_lspconfig = require('mason-lspconfig')

            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(servers),
            })

            mason_lspconfig.setup_handlers({
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            on_attach_common(client, bufnr)
                            if on_attach_specific[server_name] ~= nil then
                                on_attach_specific[server_name](client, bufnr)
                            end
                        end,
                        settings = servers[server_name],
                        before_init = before_init[server_name],
                        filetypes = filetypes[server_name],
                    })
                end,
            })

            -- Hook autoformatting to various actions
            vim.keymap.set('n', '<leader>fb', function()
                vim.lsp.buf.format()
            end, { noremap = true, desc = 'Re-[f]ormat [b]uffer' })

            vim.keymap.set('v', '<leader>fb', function()
                vim.lsp.buf.format({
                    range = {
                        ['start'] = vim.api.nvim_buf_get_mark(0, '<'),
                        ['end'] = vim.api.nvim_buf_get_mark(0, '>'),
                    },
                })
            end, { noremap = true, desc = 'Re-[f]ormat [b]lock' })
        end,
    },

    {
        -- Automates installation of formatters and linters for null-ls
        'jay-babu/mason-null-ls.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'williamboman/mason.nvim',
            {
                -- Formatter and linter configuration for mason (plays the same role as
                -- mason-lspconfig for the language servers
                'jose-elias-alvarez/null-ls.nvim',
                dependencies = { 'nvim-lua/plenary.nvim' },
                config = function()
                    local null_ls = require('null-ls')
                    null_ls.setup({
                        on_attach = function(_, bufnr)
                            vim.api.nvim_buf_set_option(bufnr, 'formatexpr', '')
                        end,
                        sources = {
                            -- lua
                            null_ls.builtins.formatting.stylua,

                            -- python
                            null_ls.builtins.formatting.black,
                            null_ls.builtins.formatting.isort,

                            -- restructuredtext
                            null_ls.builtins.diagnostics.rstcheck,

                            -- latex
                            null_ls.builtins.formatting.latexindent,
                            null_ls.builtins.diagnostics.chktex,

                            -- make
                            null_ls.builtins.diagnostics.checkmake,

                            -- bash, csh, ksh, sh, zsh
                            null_ls.builtins.formatting.beautysh,

                            -- toml
                            null_ls.builtins.formatting.taplo,

                            -- limited to: markdown, json and jsonc
                            null_ls.builtins.formatting.prettier.with({
                                filetypes = { 'markdown', 'json', 'jsonc' },
                            }),
                        },
                    })
                end,
            },
        },
        config = function()
            require('mason-null-ls').setup({
                ensure_installed = nil,
                automatic_installation = true,
            })
        end,
    },
}
