-- LaTeX snippets
-- Tutorial for maintaining this: https://www.ejmastnak.com/tutorials/vim-latex/luasnip/
-- LuaSnip homepage: https://github.com/L3MON4D3/LuaSnip

local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta

-- Returns a string containing full of `char`'s, of the same size as args[1][1]
local line_of_same_size = function(args, _, char)
    return string.rep(char, string.len(args[1][1]))
end

-- Returns a string containing the provided string, plus extra spaces to
-- make-up for the size of the parameter string in args[1][1]
local string_of_same_size = function(args, _, str)
    local diff = string.len(args[1][1]) - string.len(str)
    return str .. string.rep(' ', diff)
end

return {
    s(
        {
            trig = '%%',
            dscr = 'Standard LaTeX file header',
        },
        fmt(
            [[
            %%{}%%
            % {} %
            % {} %
            % {} %
            %%{}%%
        ]],
            {
                f(line_of_same_size, { 1 }, { user_args = { '%' } }),
                f(
                    string_of_same_size,
                    { 1 },
                    { user_args = { 'coding=utf-8' } }
                ),
                i(1, 'Andre Anjos <andre.anjos@idiap.ch>'),
                f(
                    string_of_same_size,
                    { 1 },
                    { user_args = { os.date('%c') } }
                ),
                f(line_of_same_size, { 1 }, { user_args = { '%' } }),
            }
        )
    ),
    s(
        {
            trig = 'includegraphics',
            regTrig = true,
            dscr = '\\includegraphics',
        },
        fmta(
            [[\includegraphics[width=<width>\linewidth]{<path>}]],
            { width = i(1), path = i(2, 'filepath') }
        )
    ),
    s({
        trig = '[\\]?verb%s',
        regTrig = true,
        priority = 100,
        snippetType = 'autosnippet',
        dscr = '\verb|contents|',
    }, fmta([[\verb|<contents>|]], { contents = i(1, 'verbatim text') })),
    s(
        {
            trig = '[\\]?verbatim%s',
            regTrig = true,
            priority = 100,
            snippetType = 'autosnippet',
            dscr = 'Verbatim environment',
        },
        fmta(
            [[
            \begin{verbatim}
                <contents>
            \end{verbatim}
            ]],
            { contents = i(1, 'Verbatim text') }
        )
    ),
    s(
        {
            trig = 'cols[%s]',
            regTrig = true,
            priority = 100,
            snippetType = 'autosnippet',
            dscr = 'Multi-column environment',
        },
        fmta(
            [[
            \begin{columns}
                \begin{column}{<width>\linewidth}
                    <contents>
                \end{column}
            \end{columns}
            ]],
            { width = i(1), contents = i(2) }
        )
    ),
    s(
        {
            trig = 'col2[%s]',
            regTrig = true,
            priority = 100,
            snippetType = 'autosnippet',
            dscr = 'Two-column environment',
        },
        fmta(
            [[
            \begin{columns}
                \begin{column}{0.5\linewidth}
                    <content1>
                \end{column}
                \begin{column}{0.5\linewidth}
                    <content2>
                \end{column}
            \end{columns}
            ]],
            { content1 = i(1), content2 = i(2) }
        )
    ),
    s(
        {
            trig = 'col3[%s]',
            regTrig = true,
            priority = 100,
            snippetType = 'autosnippet',
            dscr = 'Three-column environment',
        },
        fmta(
            [[
            \begin{columns}
                \begin{column}{0.333\linewidth}
                    <content1>
                \end{column}
                \begin{column}{0.333\linewidth}
                    <content2>
                \end{column}
                \begin{column}{0.333\linewidth}
                    <content3>
                \end{column}
            \end{columns}
            ]],
            { content1 = i(1), content2 = i(2), content3 = i(3) }
        )
    ),
    s(
        {
            trig = 'col4[%s]',
            regTrig = true,
            priority = 100,
            snippetType = 'autosnippet',
            dscr = 'Four-column environment',
        },
        fmta(
            [[
            \begin{columns}
                \begin{column}{0.25\linewidth}
                    <content1>
                \end{column}
                \begin{column}{0.25\linewidth}
                    <content2>
                \end{column}
                \begin{column}{0.25\linewidth}
                    <content3>
                \end{column}
                \begin{column}{0.25\linewidth}
                    <content4>
                \end{column}
            \end{columns}
            ]],
            {
                content1 = i(1),
                content2 = i(2),
                content3 = i(3),
                content4 = i(4),
            }
        )
    ),
    s(
        {
            trig = 'standalone',
            dscr = 'Standalone TiKz picture',
        },
        fmta(
            [[
            \documentclass[tikz]{standalone}

            \begin{document}
            \begin{tikzpicture}[font=\sffamily]

            <contents>

            \end{tikzpicture}
            \end{document}
        ]],
            {
                contents = i(1),
            }
        )
    ),
}
