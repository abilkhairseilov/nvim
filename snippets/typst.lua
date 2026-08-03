local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta

return {

  -- Document template
  s("doc", fmta([[
#set page(
  paper: "a4",
  margin: (x: 2.5cm, y: 2.5cm),
  numbering: "1",
)
#set text(
  font: "Libertinus Serif",
  size: 11pt,
)

#show heading: set text(weight: "bold")

= <>

<>

#show: heading => [
  #set text(weight: "bold")
  #heading
]

<>
]], { i(1, "Title"), i(2, "Author"), i(3) })),

  -- Page setup
  s("page", fmta("page(<>,)", { i(1) })),

  -- Set rule
  s("set", fmta("#set <>(<>)", { i(1, "text"), i(2) })),

  -- Show rule (basic)
  s("show", fmta("#show <>: <>", { i(1, "heading"), i(2, "set text(weight: \"bold\")") })),

  -- Show-set combo (common Typst pattern)
  s("ss", fmta("#show <>: set <>(<>)", { i(1, "heading"), i(2, "text"), i(3, "weight: \"bold\"") })),

  -- Headings
  s("sec", fmta("= <>\label{<>}\n\n<>", { i(1), i(2), i(3) })),
  s("sub", fmta("== <>\label{<>}\n\n<>", { i(1), i(2), i(3) })),
  s("subsub", fmta("=== <>\label{<>}\n\n<>", { i(1), i(2), i(3) })),

  -- Text emphasis
  s("bf", fmta("*<>*", { i(1) })),
  s("it", fmta("_<>_", { i(1) })),
  s("ul", fmta("#underline[<>]", { i(1) })),
  s("strike", fmta("#strike[<>]", { i(1) })),
  s("hl", fmta("#highlight[<>]", { i(1) })),

  -- Smallcaps
  s("sc", fmta("#text(style: \"smallcaps\")[<>]", { i(1) })),

  -- Super/subscript
  s("sup", fmta("{<>}", { i(1) })),
  s("subs", fmta("{<>}", { i(1) })),

  -- Lists
  s("bullet", fmta("- <>", { i(1) })),
  s("enum", fmta("+ <>", { i(1) })),

  -- Term list
  s("term", fmta("/ <>: <>", { i(1, "term"), i(2, "description") })),

  -- item (for both bullet and enum - inserts the right symbol based on context is hard, just make it explicit)
  -- Multi-item list: numbered
  s("listnum", fmt([[
+ {}
+ {}
+ {}
]], { i(1), i(2), i(3) })),

  -- Multi-item list: bullet
  s("listbul", fmt([[
- {}
- {}
- {}
]], { i(1), i(2), i(3) })),

  -- Math
  s("$", fmta("$<>$", { i(1) })),
  s("$$", fmta("$ <>\n$", { i(1) })),

  -- Display math with equation number
  s("eq", fmta("$ <>\n$ <eq>", { i(1) })),

  -- Math snippets (common commands)
  s("frac", fmta("$<> / <>\n$", { i(1), i(2) })),
  s("sum", fmta("$ sum_(<>=<>)^(<>)<>\n$", { i(1, "i"), i(2, "0"), i(3, "n"), i(4) })),
  s("int", fmta("$ integral_<><> dif <>\n$", { i(1), i(2), i(3) })),
  s("lim", fmta("$ lim_(<> -> <>) <>\n$", { i(1, "n"), i(2, "infty"), i(3) })),

  -- Align math
  s("align", fmta([[
$ align(
  <>
)
$
]], { i(1) })),

  -- Figure with image
  s("figure", fmta([[
#figure(
  image("<>", width: <>),
  caption: [<>],
) <label:fig->
]], { i(1, "image.png"), i(2, "100%"), i(3, "Caption"), i(4) })),

  -- Figure with code
  s("figcode", fmta([[
#figure(
  ```<>
  <>
  ```,
  caption: [<>],
) <label:fig->
]], { i(1, "typst"), i(2), i(3, "Caption"), i(4) })),

  -- Table
  s("table", fmta([[
#table(
  columns: (<>),
  inset: 10pt,
  align: center + horizon,
  [<>], [<>],
  [<>], [<>],
)
]], { i(1, "1fr, 1fr"), i(2, "Header 1"), i(3, "Header 2"), i(4, "Cell 1"), i(5, "Cell 2") })),

  -- Table with stroke styling
  s("tablex", fmta([[
#table(
  columns: (<>),
  rows: (<>),
  inset: 10pt,
  align: center + horizon,
  stroke: 0.5pt + black,
  [<>], [<>],
  [<>], [<>],
)
]], { i(1, "1fr, 1fr"), i(2, "auto, auto"), i(3, "Header 1"), i(4, "Header 2"), i(5, "Cell 1"), i(6, "Cell 2") })),

  -- Grid layout
  s("grid", fmta([[
#grid(
  columns: (<>),
  rows: (<>),
  <>
)
]], { i(1, "1fr, 1fr"), i(2, "auto"), i(3) })),

  -- Columns
  s("columns", fmta([[
#columns(<>) [
  <>
]
]], { i(1, "2"), i(2) })),

  -- Code block
  s("code", fmta([[
```<>
<>
```
]], { i(1, "typst"), i(2) })),

  -- Code block with line numbers
  s("coden", fmta([[
```<>
#show raw.where(block: true): set block(numbering: "1")
<>
```
]], { i(1, "typst"), i(2) })),

  -- Inline code (raw)
  s("raw", fmta("`<>`", { i(1) })),

  -- Links
  s("link", fmta("#link(\"<>\")[<>]", { i(1, "https://example.com"), i(2, "link text") })),
  s("maillink", fmta("#link(\"mailto:<>\")[<>]", { i(1, "email@example.com"), i(2, "email") })),

  -- Reference
  s("ref", fmta("@<>", { i(1) })),

  -- Label
  s("label", fmta("<label:<>", { i(1) })),

  -- Citation
  s("cite", fmta("[@<>]", { i(1) })),
  s("cite2", fmta("(#cite(<>, form: \"author\")", { i(1) })),

  -- Bibliography
  s("bib", fmta("#bibliography(\"<>\", style: \"<>\"", { i(1, "refs.bib"), i(2, "ieee") })),

  -- Include
  s("inc", fmta("#include \"<>\"", { i(1, "file.typ") })),
  s("import", fmta("#import \"<>\": <>", { i(1, "lib.typ"), i(2, "*") })),

  -- Quote
  s("quote", fmta([[
#quote(block: true)[
  <>
]
]], { i(1) })),

  -- Align
  s("alcenter", fmta("#align(center)[<>]", { i(1) })),
  s("alright", fmta("#align(right)[<>]", { i(1) })),

  -- Box / block
  s("box", fmta("#box[<>]", { i(1) })),
  s("block", fmta("#block[<>]", { i(1) })),

  -- Rect with styling
  s("rect", fmta("#rect(fill: <>, stroke: <>)[<>]", { i(1, "lime"), i(2, "1pt"), i(3) })),

  -- Circle / ellipse
  s("circle", fmta("#circle(fill: <>)[<>]", { i(1, "aqua"), i(2) })),
  s("ellipse", fmta("#ellipse(fill: <>)[<>]", { i(1, "yellow"), i(2) })),

  -- Line / rule
  s("rule", fmta("#line(length: <>, stroke: <>)", { i(1, "100%"), i(2, "1pt") })),

  -- Counter / state
  s("counter", fmta("#counter(<>)", { i(1, "heading") })),

  -- Numbering
  s("num", fmta("#numbering(\"<>\", <>)", { i(1, "1.1"), i(2) })),

  -- Context block (for numbered displays, counters, etc.)
  s("context", fmta([[
#context [
  <>
]
]], { i(1) })),

  -- Conditional
  s("if", fmta([[
#if <> [
  <>
] else [
  <>
]
]], { i(1), i(2), i(3) })),

  -- For loop
  s("for", fmta([[
#for <> in <> [
  <>
]
]], { i(1), i(2), i(3) })),

  -- Let binding
  s("let", fmta("#let <> = <>", { i(1, "name"), i(2) })),

  -- Function definition
  s("fn", fmta([[
#let <>(<>) = {
  <>
}
]], { i(1, "myfunc"), i(2), i(3) })),

  -- Dictionary / map
  s("dict", fmta("(<>,)", { i(1, "key: \"value\"") })),

  -- Array
  s("array", fmta("(<>)", { i(1) })),

  -- SVG / raw block with format
  s("svg", fmta([[
```svg
<>
```
]], { i(1) })),

  -- Outline / table of contents
  s("toc", fmta("#outline()", {})),
  s("outline", fmta("#outline(title: [<>])", { i(1, "Table of Contents") })),

  -- Appendix
  s("appendix", fmta("#show: appendix\n<>", { i(1) })),

  -- Enum list (multiple items)
  s("enums", fmta([[
+ <>
+ <>
+ <>
]], { i(1), i(2), i(3) })),

  -- Bullets (multiple items)
  s("bullets", fmta([[
- <>
- <>
- <>
]], { i(1), i(2), i(3) })),

  -- Term list (multiple items)
  s("terms", fmta([[
/ <>: <>
/ <>: <>
]], { i(1, "term1"), i(2, "desc1"), i(3, "term2"), i(4, "desc2") })),

  -- Image alone
  s("img", fmta("#image(\"<>\", width: <>)", { i(1, "img.png"), i(2, "80%") })),

  -- Video
  s("video", fmta("#video(\"<>\")", { i(1, "video.mp4") })),

  -- PDF embed
  s("pdf", fmta("#pdf(\"<>\", pages: <>)", { i(1, "doc.pdf"), i(2, "1") })),

  -- Glossary entry
  s("gls", fmta("#glossary(<>, [<>])", { i(1, "key"), i(2, "description") })),

  -- Symbol annotation
  s("sym", fmta("#sym.<>", { i(1) })),

  -- Emoji
  s("emoji", fmta("#emoji.<>", { i(1, "wave") })),

  -- Credit / attribution (cite a person)
  s("credit", fmta("#h(1fr) #emph[<>]", { i(1, "Name") })),

  -- Measure / units
  s("measure", fmta("<>.cm", { i(1) })),
  s("measurer", fmta("<>.pt", { i(1) })),
}
