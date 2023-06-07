local diagnostics_indicator = function(count, level, diagnostics_dict, context)
    if context.buffer:current() then
        return ''
    end
    local s = ' '
    for e, n in pairs(diagnostics_dict) do
        local sym = e == 'error' and ' '
            or (e == 'warning' and ' ' or '')
        s = s .. n .. sym
    end
    return s
end

return {
    {
        'akinsho/bufferline.nvim',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            vim.opt.termguicolors = true
            vim.opt.mousemoveevent = true
            vim.opt.mouse = 'a'
            require('bufferline').setup({
                options = {
                    diagnostics = 'nvim_lsp',
                    diagnostics_indicator = diagnostics_indicator,
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { 'close' },
                    },
                    numbers = 'ordinal',
                },
            })

            -- keymaps to easily access buffers
            for j = 1, 9, 1 do
                vim.keymap.set(
                    { 'n', 'v' },
                    string.format('<leader>%d', j),
                    function()
                        require('bufferline').go_to(j, true)
                    end,
                    { desc = string.format('Go to buffer #%d', j) }
                )
            end
            vim.keymap.set({ 'n', 'v' }, '<leader>$', function()
                require('bufferline').go_to(-1, true)
            end, { desc = 'Go to the last buffer' })
        end,
    },
}
