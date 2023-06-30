-- RestructuredText (rst) snippets
-- Tutorial for maintaining this: https://www.ejmastnak.com/tutorials/vim-latex/luasnip/
-- LuaSnip homepage: https://github.com/L3MON4D3/LuaSnip

local ls = require('luasnip')
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require('luasnip.extras.fmt').fmt

-- Returns a text node where all charaters of the input string argument are
-- replaced by a single charater to be determined
local line_of_same_size = function(args, _, char)
    return string.rep(char, string.len(args[1][1]))
end

return {
    s(
        {
            trig = 'part',
            dscr = 'Part heading',
        },
        fmt([[
            {}
            {}
            {}
        ]], {
                f(line_of_same_size, {1}, { user_args = { '#' } }),
                i(1, 'Title'),
                f(line_of_same_size, {1}, { user_args = { '#' } }),
            })
    ),
    s(
        {
            trig = 'chapter',
            dscr = 'Chapter heading',
        },
        fmt([[
            {}
            {}
            {}
        ]], {
                f(line_of_same_size, {1}, { user_args = { '*' } }),
                i(1, 'Title'),
                f(line_of_same_size, {1}, { user_args = { '*' } }),
            })
    ),
    s(
        {
            trig = 'section',
            dscr = 'Section heading',
        },
        fmt([[
            {}
            {}
        ]], {
                i(1, 'Title'),
                f(line_of_same_size, {1}, { user_args = { '=' } }),
            })
    ),
    s(
        {
            trig = 'subsection',
            dscr = 'Subsection heading',
        },
        fmt([[
            {}
            {}
        ]], {
                i(1, 'Title'),
                f(line_of_same_size, {1}, { user_args = { '-' } }),
            })
    ),
    s(
        {
            trig = 'subsubsection',
            dscr = 'Subsubsection heading',
        },
        fmt([[
            {}
            {}
        ]], {
                i(1, 'Title'),
                f(line_of_same_size, {1}, { user_args = { '^' } }),
            })
    ),
    s(
        {
            trig = 'paragraph',
            dscr = 'Paragraph heading',
        },
        fmt([[
            {}
            {}
        ]], {
                i(1, 'Title'),
                f(line_of_same_size, {1}, { user_args = { '"' } }),
            })
    ),
    s(
        {
            trig = 'table-list',
            dscr = 'List table template',
        },
        fmt(
            [[
            .. list-table:: {title}
               :widths: 25 25 50
               :header-rows: 1

               * - Header row 1, column 1
                 - Header row 1, column 2
                 - Header row 1, column 3
               * - Row 1, column 1
                 - Row 1, column 2
                 - Row 1, column 3
               * - Row 2, column 1
                 - Row 2, column 2
                 - Row 2, column 3
        ]],
            {
                title = i(1, 'Title'),
            }
        )
    ),
    s(
        {
            trig = 'table-simple',
            dscr = 'Simple table template',
        },
        fmt([[
            =====  =====  =======
            A      B      A and B
            =====  =====  =======
            False  False  False
            True   False  False
            False  True   False
            True   True   True
            =====  =====  =======
        ]], {})
    ),
    s(
        {
            trig = 'table',
            dscr = 'Table template',
        },
        fmt([[
        +------------------------+------------+----------+----------+
        | Header row, column 1   | Header 2   | Header 3 | Header 4 |
        | (header rows optional) |            |          |          |
        +========================+============+==========+==========+
        | body row 1, column 1   | column 2   | column 3 | column 4 |
        +------------------------+------------+----------+----------+
        | body row 2             | ...        | ...      |          |
        +------------------------+------------+----------+----------+
        ]], {})
    ),
}
