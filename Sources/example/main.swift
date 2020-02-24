import lex

let math_text = """
def cos(x, y)
x + y * 2 + (4 + 5) / 3

bar(3, 4)
"""
let math_tokens = lex(math_text, math_gens)
print(math_tokens)

let md_text = """
# Title {.flyer}
## SubTitle
### Paragraph title
#### Paragraph subTitle
notes
"""
let md_tokens = lex(md_text, md_gens)
print(md_tokens)

