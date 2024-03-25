return {
    -- Support for LaTeX typesetting
    {
        'lervag/vimtex',
        config = function()
            -- use nvr (required by vim-tex)
            vim.g.vimtex_compiler_progname = vim.g.pixi_env_root .. '/bin/nvr'

            -- look for the "theme/" on latex builds
            vim.env.TEXINPUTS = vim.env.PWD .. ':' .. vim.env.PWD .. '/theme:'

            -- use our preferred viewer on macOS (w/ Apple Silicon)
            if io.popen('uname -m'):read('*a'):match('%w+'):lower() == 'arm64' then
                vim.g.vimtex_view_method = 'skim'
            end

            vim.g.tex_flavor = 'latex'

            -- we use tresitter instead
            vim.g.vimtex_syntax_enabled = 0
        end,
    },
}
