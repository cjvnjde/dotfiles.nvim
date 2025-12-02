local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local function get_filename_pascal()
  local filename = vim.fn.expand "%:t:r"
  return filename
    :gsub("(%a)([%w_']*)", function(first, rest)
      return first:upper() .. rest:lower()
    end)
    :gsub("[-_]", "")
end

ls.add_snippets("typescriptreact", {
  s(
    "rsc",
    fmt(
      [[
  export const {} = () => {{
    return (
      <div>
        {}
      </div>
    );
  }};
  ]],
      {
        f(get_filename_pascal),
        i(0),
      }
    )
  ),
})
