# lex

`lex` identifies langage elements in a text. First, you define langage elements using <a href="https://en.wikipedia.org/wiki/Regular_expression">regular expressions</a>, in a dictionary. Then, you call `lex` with that dictionary, and a text. `lex` returns the list of elements matching the dictionary. There is an example further down.

In other words, `lex` is a <a href="https://en.wikipedia.org/wiki/Lexical_analysis#Tokenization">'tokenizer'</a> that works with regular expressions. 'Tokenisation' is the first step for lexical analysis. `lex` is only around 30 lines of code, but it's a template code. That means it sound be isolated for reuse because works for any dictionary you define, i.e. any langage you define.
    
The following step after `lex` should try to apply an algebra to the identified langage elements. An algebra defines operators. Operators have a priority, a number of operands, and can be postfix/prefix/infix with its operands. We should identify operators within our langage elements, and reorder the elements according to the operators characteristics, in order to obtain a 'Reverse Polish Notation' : <operator> <operands> ... . After 'RPN' transformation, our original text should be used as a program in a state machine ...

___

Here is an example, for some markdown langage : 
- Define the langage elements
```swift
public enum MdToken {
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
public let md_gens: [Gen<MdToken>] = [
    Gen<MdToken>(regex: "[\r\n]" , funct: { _ in nil } ),
    Gen<MdToken>(regex: "[ \ta-zA-Z0-9]+" , funct: { .Text($0) } ),
    Gen<MdToken>(regex: "#[ \t]+" , funct: { _ in .Level1 } ),
    Gen<MdToken>(regex: "##[ \t]+" , funct: { _ in .Level2 } ),
    Gen<MdToken>(regex: "###[ \t]+" , funct: { _ in .Level3 } ),
    Gen<MdToken>(regex: "####[ \t]+" , funct: { _ in .Level4 } ),
    Gen<MdToken>(regex: "\\{" , funct: { _ in .BracketOpen } ),
    Gen<MdToken>(regex: "\\}" , funct: { _ in .BracketClose } ),
    Gen<MdToken>(regex: "\\.[a-zA-Z0-9]+" , funct: { .Class(String($0.dropFirst())) } )
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

let tokens = lex(text, md_gens)

print(tokens)
````

- `lex' returns identified elements : 
```swift
[
lex.MdToken.Level1, lex.MdToken.Text("Title "), lex.MdToken.BracketOpen,
lex.MdToken.Class("flyer"), lex.MdToken.BracketClose, lex.MdToken.Level2,
lex.MdToken.Text("SubTitle"), lex.MdToken.Level3, lex.MdToken.Text("Paragraph title"),
lex.MdToken.Level4, lex.MdToken.Text("Paragraph subTitle"),lex.MdToken.Text("notes")
]
```
