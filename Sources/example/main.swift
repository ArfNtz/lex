import lex

let math_text = """
def cos(x, y)
x + y * 2 + (4 + 5) / 3

bar(3, 4)
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

