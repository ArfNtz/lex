# lex

The name `lex` is inspired from this <a href="https://en.wikipedia.org/wiki/Lex_(software)">tool</a> that generates lexical analyzers.

Here, `lex` is a 30 lines program that identifies langage elements in a text, this way : 

- Define the <a href="https://en.wikipedia.org/wiki/Lexical">lexical</a> and the dictionary, using <a href="https://en.wikipedia.org/wiki/Regular_expression">regular expressions</a>, on the definition part. 
- Call `lex` with a text, and that dictionary. 
- `lex` returns the list of langage  elements matching the dictionary. 

There are two examples further down, one for a mathematical langage, and one for a markdown langage.

In other words, `lex` is a <a href="https://en.wikipedia.org/wiki/Lexical_analysis#Tokenization">'tokenizer'</a> that works with regular expressions. 'Tokenisation' is the first step for lexical analysis. `lex` is only around 30 lines of code, but it's a template code. That means it should be isolated for reuse because it **works for the dictionary you define**, i.e. **the langage you define**. Swift's syntax allows to do this in a simple and short way.
    
After `lex`, a following step could apply an algebra to the identified langage elements. An algebra defines operators. Operators have a priority, a number of operands, and can be postfix/prefix/infix with its operands. We should identify operators within our langage elements, and reorder the elements according to the operators characteristics, in order to obtain a 'Reverse Polish Notation' : operands followed by operator ... . After this 'RPN' transformation, our original text could be used as a program in a state machine ...

___

# Examples

## Some markdown langage

Here is an example, for some <a href="https://fr.wikipedia.org/wiki/Markdown">markdown</a> langage. We're trying to find the langage elements in this markdown text : 
```
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

## Some mathematical langage

Here is an example, for some mathematical langage. We're trying to find the langage elements in this markdown text : 
```
bar(x, y) inf
x + y * 8 + (4 - 1) / 7
foo(8, 2)
```

- Define the langage elements
```swift
// langage elements
public enum MathLexem {
    case Infinite
    case Identifier(String)
    case Number(Float)
    case ParensOpen
    case ParensClose
    case Comma
    case BinaryOp(String)
}
```

- Write the definitions
```swift
// dictionary
public let math_dict: [Def<MathLexem>] = [
    Def<MathLexem>(regex: "[ \t\n]" , funct: { _ in nil } ),
    Def<MathLexem>(regex: "[a-zA-Z][a-zA-Z0-9]*" , funct: { $0 == "inf" ? .Infinite : .Identifier($0) } ),
    Def<MathLexem>(regex: "#[0-9.]+" , funct: {(r: String) in .Number((r as NSString).floatValue) } ),
    Def<MathLexem>(regex: "\\(" , funct: { _ in .ParensOpen } ),
    Def<MathLexem>(regex: "\\)" , funct: { _ in .ParensClose } ),
    Def<MathLexem>(regex: "," , funct: { _ in .Comma } ),
    Def<MathLexem>(regex: "[+\\-*/]" , funct: { .BinaryOp($0) } )
]
```

- Then call `lex` on a text : 
````swift
let math_text =
"""
  bar(x, y) inf
  x + y * 8 + (4 - 1) / 7
  foo(8, 2)
"""

let math_elements = lex(math_text, math_dict)

print(math_elements)
````

- `lex' returns identified elements : 
```swift
[
lex.MathLexem.Identifier("bar"), lex.MathLexem.ParensOpen, lex.MathLexem.Identifier("x"),
lex.MathLexem.Comma, lex.MathLexem.Identifier("y"), lex.MathLexem.ParensClose,
lex.MathLexem.Infinite, lex.MathLexem.Identifier("x"), lex.MathLexem.BinaryOp("+"),
lex.MathLexem.Identifier("y"), lex.MathLexem.BinaryOp("*"), lex.MathLexem.BinaryOp("+"),
lex.MathLexem.ParensOpen, lex.MathLexem.BinaryOp("-"), lex.MathLexem.ParensClose,
lex.MathLexem.BinaryOp("/"), lex.MathLexem.Identifier("foo"), lex.MathLexem.ParensOpen,
lex.MathLexem.Comma, lex.MathLexem.ParensClose
]
```
