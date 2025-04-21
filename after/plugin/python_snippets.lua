local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("python", {
  s('"""', {
    t({ '"""', "" }),
    i(1, "Summary of function"),
    t({ "", "" }),
    t('"""'),
  }),
})

