-- Here is a list of LSP servers from mason we want installed, and (eventually)
-- configured specifically (via mason-lspconfig).
--
-- The server (package) needs to be supported by mason:
-- https://mason-registry.dev/registry/list
--
-- Each key in this table corresponds to a "lua" name translation as defined by
-- mason-lspconfig:
-- https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/mason-lspconfig-mapping.txt
--
-- The values associated with each key, with the following keys and values (all
-- keys are optional):
--
--   * before_init (function) - setup before initialisation
--   * settings (table) - configuration passed to the server
--   * filetypes (table) - filetypes that should be used by the server.
--     This list overrides default file types associated with such server. Use
--     only to limit the filetypes that will be associated with this server.
--   * on_attach (function) - function to setup buffer-lsp interactions (e.g.
--     keybindings), **beyond** what is set with
--     on_buffer_attach_common_actions() below.

local function get_python_path(workspace)
    local path = require('lspconfig/util').path

    -- Use activated virtualenv.

    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
    end

    if vim.env.CONDA_PREFIX then
        return path.join(vim.env.CONDA_PREFIX, 'bin', 'python')
    end

    -- Fallback to system Python.
    return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

local lsp_servers = {
    -- mason (mason-lsp-config): lua-language-server (lua_ls)
    -- https://mason-registry.dev/registry/list#lua-language-server
    -- filetype: lua
    lua_ls = {
        settings = {
            Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = { 'vim' } },
                workspace = {
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                },
                telemetry = { enable = false },
            },
        },
    },

    -- mason (mason-lsp-config): pyright (pyright)
    -- https://mason-registry.dev/registry/list#pyright
    -- filetype: python
    -- pyright is required for type checking (not implemented on ruff)
    pyright = {
        before_init = function(_, config)
            -- Changes the Python path when the server is started
            config.settings.python.pythonPath = get_python_path(config)
        end,
        settings = { python = {} },
    },

    -- mason (mason-lsp-config): ruff (ruff_lsp)
    -- https://mason-registry.dev/registry/list#ruff-lsp
    -- filetype: python
    -- ruff LSP will run lint checks on python code
    ruff_lsp = {
        on_attach = function(client, _)
            -- defers some capabilities on python LSP to pyright
            client.server_capabilities.hoverProvider = false
        end,
    },

    -- mason (mason-lsp-config): bash-language-server (bashls)
    -- https://mason-registry.dev/registry/list#bash-language-server
    -- filetype: sh
    bashls = {},

    -- mason (mason-lsp-config): json-lsp (jsonls)
    -- https://mason-registry.dev/registry/list#json-lsp
    -- filetype: json
    jsonls = {},

    -- mason (mason-lsp-config): css-lsp (cssls)
    -- https://mason-registry.dev/registry/list#css-lsp
    -- filetype: css
    cssls = {},

    -- mason (mason-lsp-config): texlab (texlab)
    -- https://mason-registry.dev/registry/list#texlab
    -- filetype: tex, bib
    texlab = {
        filetypes = { 'tex', 'bib' },
        -- settings = {
        -- defaults:
        -- auxDirectory = ".",
        -- bibtexFormatter = "texlab",
        -- build = {
        --     args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
        --     executable = "latexmk",
        --     forwardSearchAfter = false,
        --     onSave = false
        -- },
        -- chktex = {
        --     onEdit = false,
        --     onOpenAndSave = false
        -- },
        -- diagnosticsDelay = 300,
        -- formatterLineLength = 80,
        -- forwardSearch = {
        --     args = {}
        -- },
        -- latexFormatter = "latexindent",
        -- latexindent = {
        --     modifyLineBreaks = false
        -- }
        -- },
    },

    -- mason (mason-lsp-config): dot-language-server (dotls)
    -- https://mason-registry.dev/registry/list#dot-language-server
    -- filetype: dot
    dotls = {},

    -- mason (mason-lsp-config): dockerfile-language-server (dockerls)
    -- https://mason-registry.dev/registry/list#dockerfile-language-server
    -- filetype: dockerfile
    dockerls = {},

    -- mason (mason-lsp-config): html-lsp (html)
    -- https://mason-registry.dev/registry/list#html-lsp
    -- filetype: html
    html = {},

    -- mason (mason-lsp-config): esbonio (esbonio)
    -- https://mason-registry.dev/registry/list#esbonio
    -- filetype: html
    esbonio = {
        filetypes = { 'rst' },
    },

    -- mason (mason-lsp-config): yaml-language-server (yamlls)
    -- https://mason-registry.dev/registry/list#yaml-language-server
    -- filetype: yaml
    yamlls = {
        on_attach = function(_, bufnr)
            -- if the buffer name matches `meta.yml`, disables
            -- diagnostics as this is a jinja2 template that is badly
            -- named...
            local filename = 'meta.yaml'
            if
                vim.api.nvim_buf_get_name(bufnr):sub(-string.len(filename))
                == filename
            then
                vim.diagnostic.disable(bufnr)
            end
        end,
    },

    -- mason (mason-lsp-config): taplo (taplo)
    -- https://mason-registry.dev/registry/list#taplo
    -- filetype: toml
    taplo = {},
}

--  This function gets run when an LSP connects to a particular buffer.
local on_buffer_attach_common_actions = function(_, bufnr)
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

    -- Creates a command `:LspFormat` local to the LSP buffer
    vim.api.nvim_create_user_command('LspFormat', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

return {

    -- NOTE: This is where your plugins related to LSP can be installed.
    -- Configuration should go in the following order:
    -- 1. mason.nvim (Portable package manager for Neovim that runs everywhere
    --    Neovim runs. It allows installation of packages required for linting
    --    and formatting.)
    -- 2. mason-lspconfig.nvim (bridges mason.nvim with the lspconfig plugin -
    --    making it easier to use both plugins together.)
    -- 3. Setup servers via lspconfig
    {
        -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason-lspconfig.nvim',
                dependencies = {
                    {
                        'williamboman/mason.nvim',
                        config = function()
                            require('mason').setup()
                        end,
                        build = ':MasonUpdate',
                        dependencies = {
                            -- Implements MasonUpdateAll command
                            'Zeioth/mason-extra-cmds',
                            opts = {},
                        },
                        cmd = {
                            'Mason',
                            'MasonInstall',
                            'MasonUninstall',
                            'MasonUninstallAll',
                            'MasonLog',
                            'MasonUpdate',
                            'MasonUpdateAll', -- provided by `Zeioth/mason-extra-cmds`
                        },
                    },
                },
                config = function()
                    require('mason-lspconfig').setup()
                end,
            },

            -- Automatically install LSPs to stdpath for neovim
            -- Useful status updates for LSP
            { 'j-hui/fidget.nvim', branch = 'legacy', opts = {} },

            -- Additional lua configuration, makes nvim stuff amazing!
            { 'folke/neodev.nvim', opts = {} },
        },
        config = function()
            -- nvim-cmp supports additional completion capabilities, so
            -- broadcast that to servers
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities =
                require('cmp_nvim_lsp').default_capabilities(capabilities)

            -- Ensure the servers above are installed
            local mason_lspconfig = require('mason-lspconfig')

            mason_lspconfig.setup({
                ensure_installed = vim.tbl_keys(lsp_servers),
            })

            mason_lspconfig.setup_handlers({
                -- This function is called once for each of the servers defined
                function(server_name)
                    require('lspconfig')[server_name].setup({
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            on_buffer_attach_common_actions(client, bufnr)
                            if lsp_servers[server_name]['on_attach'] ~= nil then
                                lsp_servers[server_name]['on_attach'](
                                    client,
                                    bufnr
                                )
                            end
                        end,
                        settings = lsp_servers[server_name]['settings'] or {},
                        before_init = lsp_servers[server_name]['before_init'],
                        filetypes = lsp_servers[server_name]['filetypes'],
                    })
                end,
            })
        end,
    },
}
