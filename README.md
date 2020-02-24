# lex

`lex` can identify langage elements in a text. First, langage elements are defined by regular expressions, in a dictionary. Then, `lex` is given the dictionary, a text, and returns a list of matching elements.

Here is an example form some markdown text : 
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

- Call lex on a text : 
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

- The result is : 
