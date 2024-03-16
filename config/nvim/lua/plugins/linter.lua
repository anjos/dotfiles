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
        -- A linter runner for Neovim.
        -- https://github.com/mfussenegger/nvim-lint
        -- 'mfussenegger/nvim-lint',
        -- dependencies = {
        --     {
        --         'williamboman/mason.nvim',
        --         config = function()
        --             require('mason').setup()
        --         end,
        --         build = ':MasonUpdate',
        --     },
        -- },
        -- config = function()
            -- mason_ensure_installed({
            --     -- 'chktex', -- available with mactex
            --     -- 'luacheck', -- have to reconfigure for neovim
            --     -- 'markdownlint', -- too pedantic
            --     -- 'pydocstyle', -- too pedantic
            --     -- 'rstcheck', -- needs some love to work properly
            --     -- 'ruff', -- use ruff-lsp for extra diagnostics
            --     -- 'yamllint', -- too pedantic
            -- })

            -- require('lint').linters_by_ft = {
            --     -- markdown = { 'markdownlint' },
            --     -- python = { 'pydocstyle'}, -- 'ruff
            --     -- lua = { 'luacheck' },
            --     -- tex = { 'chktex' }, -- broken?
            --     -- yaml = { 'yamllint' },
            --     -- rst = { 'rstcheck' }, -- misses sphinx/toml support?
            -- }
            --
            -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            --     callback = function()
            --         require("lint").try_lint()
            --     end,
            -- })
        -- end,
    },
}
