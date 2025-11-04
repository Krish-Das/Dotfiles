---@diagnostic disable: undefined-global
return {
  s({ trig = "clg", snippetType = "autosnippet" }, fmta("console.log(<>)", { i(1) })),
  s(
    { trig = "rfc", snippetType = "autosnippet" },
    fmta("export default function <>() {\n\treturn <>\n}", {
      i(1),
      i(2),
    })
  ),
  s(
    { trig = "imp" },
    fmta('import { <> } from "<>"', {
      i(1),
      i(2),
    })
  ),
}
