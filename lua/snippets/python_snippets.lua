-- ~/.config/nvim/lua/snippets/python.lua
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("doc", {
    t({ '"""' }),
    t({ "", "" }),
    i(1, "Short description."),
    t({ "", "", "Args:", "    " }),
    i(2, "param (type): description"),
    t({ "", "", "Returns:", "    " }),
    i(3, "type: description"),
    t({ "", "", "Raises:", "    " }),
    i(4, "ExceptionType: condition"),
    t({ "", '"""' }),
  }),
}

