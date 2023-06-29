-- Global snippets (applicable to all filetypes)
-- Tutorial for maintaining this: https://www.ejmastnak.com/tutorials/vim-latex/luasnip/
-- LuaSnip homepage: https://github.com/L3MON4D3/LuaSnip

local ls = require('luasnip')
local s = ls.snippet -- (trigger, nodes, opts)
local sn = ls.snippet_node
local t = ls.text_node
local d = ls.dynamic_node
local partial = require('luasnip.extras').partial

return {
    s({ trig = 'datetime', dscr = 'Date and time with %c format' }, {
        partial(os.date, '%c'),
    }),
    s({
        trig = 'namemail',
        dscr = 'My name and Gmail address',
        priority = 100,
        snippetType = 'autosnippet',
    }, {
        t('Andre Anjos <andre.dos.anjos@gmail.com>'),
    }),
    s({
        trig = 'inamemail',
        dscr = 'My name and Idiap address',
        priority = 100,
        snippetType = 'autosnippet',
    }, {
        t('Andre Anjos <andre.anjos@idiap.ch>'),
    }),
    s({ trig = 'utf8', dscr = 'UTF-8 editor hint' }, {
        t('coding=utf-8'),
    }),
}
