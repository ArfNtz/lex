# lex

`lex` identifies langage elements in a text. First, you define langage elements using <a href="https://en.wikipedia.org/wiki/Regular_expression">regular expressions</a>, in a dictionary. Then, you call `lex` with that dictionary, and a text. `lex` returns the list of elements matching the dictionary. There is an example further down.

In other words, `lex` is a <a href="https://en.wikipedia.org/wiki/Lexical_analysis#Tokenization">'tokenizer'</a> that works with regular expressions. 'Tokenisation' is the first step for lexical analysis. `lex` is only around 30 lines of code, but it's a template code. That means it should be isolated for reuse because it works for any dictionary you define, i.e. any langage you define.
    
The following step after `lex` should apply an algebra to the identified langage elements. An algebra defines operators. Operators have a priority, a number of operands, and can be postfix/prefix/infix with its operands. We should identify operators within our langage elements, and reorder the elements according to the operators characteristics, in order to obtain a 'Reverse Polish Notation' : operator operands ... . After 'RPN' transformation, our original text should be used as a program in a state machine ...

___

Here is an example, for some <a href="https://fr.wikipedia.org/wiki/Markdown">markdown</a> langage. We're trying to find the langage elements in this markdown text : 
```
let text = """
# Title {.flyer}
## SubTitle
### Paragraph title
#### Paragraph subTitle
notes
```

- Define the langage elements
```swift
// langage elements
public enum MdLexem {
    case Level1         // # level 1
    case Level2         // ##  level 2
    case Level3         // ###  level 3
    case Level4         // ####  level 4
    case Text(String)   // some text
    case BracketOpen    // {
    case BracketClose   // }
    case Class(String)  // .fooClass
    case Other(String)  // unknown
}
```

- Write the definitions
```swift
// dictionary
public let md_dict: [Def<MdLexem>] = [
    Def<MdLexem>(regex: "[\r\n]" , funct: { _ in nil } ),
    Def<MdLexem>(regex: "[ \ta-zA-Z0-9]+" , funct: { .Text($0) } ),
    Def<MdLexem>(regex: "#[ \t]+" , funct: { _ in .Level1 } ),
    Def<MdLexem>(regex: "##[ \t]+" , funct: { _ in .Level2 } ),
    Def<MdLexem>(regex: "###[ \t]+" , funct: { _ in .Level3 } ),
    Def<MdLexem>(regex: "####[ \t]+" , funct: { _ in .Level4 } ),
    Def<MdLexem>(regex: "\\{" , funct: { _ in .BracketOpen } ),
    Def<MdLexem>(regex: "\\}" , funct: { _ in .BracketClose } ),
    Def<MdLexem>(regex: "\\.[a-zA-Z0-9]+" , funct: { .Class(String($0.dropFirst())) } )
]
```

- Then call `lex` on a text : 
````swift
let text = """
# Title {.flyer}
## SubTitle
### Paragraph title
#### Paragraph subTitle
notes
"""

let elements = lex(text, md_dict)

print(elements)
````

- `lex' returns identified elements : 
```swift
[
lex.MdLexem.Level1, lex.MdLexem.Text("Title "), lex.MdLexem.BracketOpen,
lex.MdLexem.Class("flyer"), lex.MdLexem.BracketClose, lex.MdLexem.Level2,
lex.MdLexem.Text("SubTitle"), lex.MdLexem.Level3, lex.MdLexem.Text("Paragraph title"),
lex.MdLexem.Level4, lex.MdLexem.Text("Paragraph subTitle"),lex.MdLexem.Text("notes")
]
```
