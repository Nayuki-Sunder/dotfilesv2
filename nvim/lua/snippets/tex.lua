local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt

-- 1. Math Context Helpers
local tex_utils = {}
tex_utils.in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex_utils.in_text = function()
  return not tex_utils.in_mathzone()
end
tex_utils.in_comment = function()
  return vim.fn["vimtex#syntax#in_comment"]() == 1
end

return {
  -- ==========================================
  --              MATH MODES
  -- ==========================================
  -- mk -> $...$
  s({ trig = "mk", snippetType = "autosnippet" }, fmt("${}$", { i(1) })),
  -- dm -> \[ ... \]
  s(
    { trig = "dm", snippetType = "autosnippet" },
    fmt(
      [[
  \[
  {}
  \]
  ]],
      { i(1) }
    )
  ),

  -- ==========================================
  --             ENVIRONMENTS
  -- ==========================================
  -- beg -> \begin{...} ... \end{...}
  s(
    { trig = "beg", snippetType = "autosnippet" },
    fmt(
      [[
  \begin{{{}}}
  {}
  \end{{{}}}
  ]],
      { i(1), i(2), rep(1) }
    )
  ),

  -- ==========================================
  --            GREEK LETTERS
  -- ==========================================
  s({ trig = "@a", snippetType = "autosnippet" }, { t("\\alpha") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@b", snippetType = "autosnippet" }, { t("\\beta") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@g", snippetType = "autosnippet" }, { t("\\gamma") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@G", snippetType = "autosnippet" }, { t("\\Gamma") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@d", snippetType = "autosnippet" }, { t("\\delta") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@D", snippetType = "autosnippet" }, { t("\\Delta") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@e", snippetType = "autosnippet" }, { t("\\epsilon") }, { condition = tex_utils.in_mathzone }),
  s({ trig = ":e", snippetType = "autosnippet" }, { t("\\varepsilon") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@z", snippetType = "autosnippet" }, { t("\\zeta") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@t", snippetType = "autosnippet" }, { t("\\theta") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@T", snippetType = "autosnippet" }, { t("\\Theta") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@l", snippetType = "autosnippet" }, { t("\\lambda") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@L", snippetType = "autosnippet" }, { t("\\Lambda") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@s", snippetType = "autosnippet" }, { t("\\sigma") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@S", snippetType = "autosnippet" }, { t("\\Sigma") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@o", snippetType = "autosnippet" }, { t("\\omega") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "@O", snippetType = "autosnippet" }, { t("\\Omega") }, { condition = tex_utils.in_mathzone }),

  -- ==========================================
  --           BASIC OPERATIONS
  -- ==========================================
  s({ trig = "sr", snippetType = "autosnippet" }, { t("^{2}") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "cb", snippetType = "autosnippet" }, { t("^{3}") }, { condition = tex_utils.in_mathzone }),
  s(
    { trig = "rd", snippetType = "autosnippet" },
    fmt("^{{{}}}{}", { i(1), i(2) }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { trig = "_", snippetType = "autosnippet" },
    fmt("_{{{}}}{}", { i(1), i(2) }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { trig = "sts", snippetType = "autosnippet" },
    fmt("_\\text{{{}}}", { i(1) }),
    { condition = tex_utils.in_mathzone }
  ),
  s({ trig = "sq", snippetType = "autosnippet" }, fmt("\\sqrt{{{}}}", { i(1) }), { condition = tex_utils.in_mathzone }),
  s(
    { trig = "//", snippetType = "autosnippet" },
    fmt("\\frac{{{}}}{{{}}}", { i(1), i(2) }),
    { condition = tex_utils.in_mathzone }
  ),
  s({ trig = "ee", snippetType = "autosnippet" }, fmt("e^{{{}}}", { i(1) }), { condition = tex_utils.in_mathzone }),
  s({ trig = "invs", snippetType = "autosnippet" }, { t("^{-1}") }, { condition = tex_utils.in_mathzone }),

  -- ==========================================
  --             REGEX TRIGGERS
  -- ==========================================
  -- Auto subscript: x1 -> x_{1}
  s(
    { trig = "([A-Za-z])(%d)", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip)
      return snip.captures[1] .. "_{" .. snip.captures[2] .. "}"
    end),
    { condition = tex_utils.in_mathzone }
  ),

  -- Auto subscript with two digits: x_12 -> x_{12}
  s(
    { trig = "([A-Za-z])_(%d%d)", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip)
      return snip.captures[1] .. "_{" .. snip.captures[2] .. "}"
    end),
    { condition = tex_utils.in_mathzone }
  ),

  -- Auto modifiers: xhat -> \hat{x}, xbar -> \bar{x}
  s(
    { trig = "([a-zA-Z])hat", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip)
      return "\\hat{" .. snip.captures[1] .. "}"
    end),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    { trig = "([a-zA-Z])bar", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip)
      return "\\bar{" .. snip.captures[1] .. "}"
    end),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    { trig = "([a-zA-Z])vec", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip)
      return "\\vec{" .. snip.captures[1] .. "}"
    end),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    { trig = "([a-zA-Z])dot", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip)
      return "\\dot{" .. snip.captures[1] .. "}"
    end),
    { condition = tex_utils.in_mathzone }
  ),

  s(
    { trig = "([a-zA-Z])ddot", regTrig = true, snippetType = "autosnippet" },
    f(function(_, snip)
      return "\\ddot{" .. snip.captures[1] .. "}"
    end),
    { condition = tex_utils.in_mathzone }
  ),

  -- ==========================================
  --        SYMBOLS & LOGIC
  -- ==========================================
  s({ trig = "ooo", snippetType = "autosnippet" }, { t("\\infty") }, { condition = tex_utils.in_mathzone }),
  s(
    { trig = "sum", snippetType = "autosnippet" },
    fmt("\\sum_{{{}={}}}^{{{}}} {}", { i(1, "i"), i(2, "1"), i(3, "N"), i(4) }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { trig = "prod", snippetType = "autosnippet" },
    fmt("\\prod_{{{}={}}}^{{{}}} {}", { i(1, "i"), i(2, "1"), i(3, "N"), i(4) }),
    { condition = tex_utils.in_mathzone }
  ),
  s(
    { trig = "lim", snippetType = "autosnippet" },
    fmt("\\lim_{{{} \\to {}}} {}", { i(1, "n"), i(2, "\\infty"), i(3) }),
    { condition = tex_utils.in_mathzone }
  ),

  s({ trig = "+-", snippetType = "autosnippet" }, { t("\\pm") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "...", snippetType = "autosnippet" }, { t("\\dots") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "nabl", snippetType = "autosnippet" }, { t("\\nabla") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "xx", snippetType = "autosnippet" }, { t("\\times") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "**", snippetType = "autosnippet" }, { t("\\cdot") }, { condition = tex_utils.in_mathzone }),

  s({ trig = "!=", snippetType = "autosnippet" }, { t("\\neq") }, { condition = tex_utils.in_mathzone }),
  s({ trig = ">=", snippetType = "autosnippet" }, { t("\\geq") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "<=", snippetType = "autosnippet" }, { t("\\leq") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "=>", snippetType = "autosnippet" }, { t("\\implies") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "=<", snippetType = "autosnippet" }, { t("\\impliedby") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "->", snippetType = "autosnippet" }, { t("\\to") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "!>", snippetType = "autosnippet" }, { t("\\mapsto") }, { condition = tex_utils.in_mathzone }),

  s({ trig = "inn", snippetType = "autosnippet" }, { t("\\in") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "notin", snippetType = "autosnippet" }, { t("\\not\\in") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "set", snippetType = "autosnippet" }, fmt("\\{{{}\\}}", { i(1) }), { condition = tex_utils.in_mathzone }),
  s({ trig = "CC", snippetType = "autosnippet" }, { t("\\mathbb{C}") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "RR", snippetType = "autosnippet" }, { t("\\mathbb{R}") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "ZZ", snippetType = "autosnippet" }, { t("\\mathbb{Z}") }, { condition = tex_utils.in_mathzone }),
  s({ trig = "NN", snippetType = "autosnippet" }, { t("\\mathbb{N}") }, { condition = tex_utils.in_mathzone }),

  -- ==========================================
  --        DERIVATIVES & INTEGRALS
  -- ==========================================
  s({ trig = "ddt", snippetType = "autosnippet" }, { t("\\frac{d}{dt} ") }, { condition = tex_utils.in_mathzone }),
  s(
    { trig = "dint", snippetType = "autosnippet" },
    fmt("\\int_{{{}}}^{{{}}} {} \\, d{}", { i(1, "0"), i(2, "1"), i(3), i(4, "x") }),
    { condition = tex_utils.in_mathzone }
  ),
}
