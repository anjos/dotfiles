-- Python snippets
-- Tutorial for maintaining this: https://www.ejmastnak.com/tutorials/vim-latex/luasnip/
-- LuaSnip homepage: https://github.com/L3MON4D3/LuaSnip

local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require('luasnip.extras.fmt').fmt

return {
    s({
        trig = 'pdb%s',
        regTrig = true,
        wordTrig = true,
        dscr = 'Standard Python debugger',
        priority = 100,
        snippetType = 'autosnippet',
    }, {
        t('__import__("pdb").set_trace()'),
    }),
    s({
        trig = 'ipdb%s',
        regTrig = true,
        wordTrig = true,
        dscr = 'IPython debugger',
        priority = 100,
        snippetType = 'autosnippet',
    }, {
        t('__import__("ipdb").set_trace()'),
    }),
    s(
        {
            trig = 'rst-numpy-func',
            dscr = 'Numpy-style docstring for functions',
        },
        fmt(
            [[
        """{summary}

        Extended description of the function.


        Parameters
        ----------

        param1
            Description of parameter 1

        param2
            Description of parameter 2


        Returns
        -------

        retval1
            Description of return value 1

        retval2
            Description of return value 2


        Raises
        ------

        Exception
            Explanation why it is raised
        """
        ]],
            {
                summary = i(1, 'Summary line.'),
            }
        )
    ),
    s(
        {
            trig = 'rst-numpy-class',
            dscr = 'Numpy-style docstring for classes',
        },
        fmt(
            [[
        """{summary}

        Extended description of the class.


        Attributes
        ----------

        attr1
            Description of instance attribute 1

        attr2
            Description of instance attribute 2
        """
        ]],
            {
                summary = i(1, 'Summary line.'),
            }
        )
    ),
    s(
        {
            trig = 'rst-google-func',
            dscr = 'Google-style docstring for functions',
        },
        fmt(
            [[
        """{summary}

        Extended description of the function.


        Args:
            param1: Description of parameter 1
            param2: Description of parameter 2


        Returns:
            retval1: Description of return value 1
            retval2: Description of return value 2


        Raises:
            Exception: Explanation why it is raised
        """
        ]],
            {
                summary = i(1, 'Summary line.'),
            }
        )
    ),
    s(
        {
            trig = 'rst-google-class',
            dscr = 'Google-style docstring for classes',
        },
        fmt(
            [[
        """{summary}

        Extended description of the class.


        Attributes:
            attr1: Description of instance attribute 1
            attr2: Description of instance attribute 2
        """
        ]],
            {
                summary = i(1, 'Summary line.'),
            }
        )
    ),
    s(
        {
            trig = 'rst-list-table',
            dscr = 'RST list table template',
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
            trig = 'rst-simple-table',
            dscr = 'RST simple table template',
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
            trig = 'rst-table',
            dscr = 'RST table template',
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
    s(
        {
            trig = 'rst-pyfunc',
            dscr = 'RST function reference',
        },
        fmt([[:py:func:`{name}`]], {
            name = i(1, 'module.function'),
        })
    ),
}
