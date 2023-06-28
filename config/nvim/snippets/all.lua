-- Global snippets (applicable to all filetypes)
-- Tutorial for maintaining this: https://www.ejmastnak.com/tutorials/vim-latex/luasnip/
-- LuaSnip homepage: https://github.com/L3MON4D3/LuaSnip

local ls = require('luasnip')

-- shortcuts
local s = ls.snippet -- (trigger, nodes, opts)

-- types of nodes a snippet can have
local sn = ls.snippet_node
local t = ls.text_node -- text will be considered complete after insertion
-- local i = ls.insert_node -- text will be highlighted after insertion
-- local f = ls.function_node
-- local c = ls.choice_node
local d = ls.dynamic_node
-- local r = ls.restore_node

-- Returns a snippet_node wrapped around a text_node whose text value is set to
-- the current date in the desired format.
local datetime_input = function(_, _, _, fmt)
    return sn(nil, t(os.date(fmt or '%c')))
end

return {
    s({ trig = 'datetime', dscr = 'Date and time with %c format' }, {
        d(1, datetime_input, {}, { user_args = { '%c' } }),
    }),
    s({ trig = 'namemail', dscr = 'My name and Gmail address' }, {
        t('Andre Anjos <andre.dos.anjos@gmail.com>'),
    }),
    s({ trig = 'inamemail', dscr = 'My name and Idiap address' }, {
        t('Andre Anjos <andre.anjos@idiap.ch>'),
    }),
    s({ trig = 'utf8', dscr = 'UTF-8 editor hint' }, {
        t('coding=utf-8'),
    }),
}
