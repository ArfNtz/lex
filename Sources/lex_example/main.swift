import lex

let math_text = """
  bar(x, y) inf
  x + y * 8 + (4 - 1) / 7
  foo(8, 2)
"""
let math_elements = lex(math_text, math_dict)
print(math_elements)

let md_text = """
# Title {.flyer}
## SubTitle
### Paragraph title
#### Paragraph subTitle
notes
"""
let md_elements = lex(md_text, md_dict)
print(md_elements)

