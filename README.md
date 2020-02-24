# lex

`lex` can identify langage elements in a text. First, you define langage elements using regular expressions, in a dictionary. Then, you call `lex` with that dictionary and a text. `lex` returns the list of elements matching the dictionary.

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

- `lex' gives the elements : 
```swift
[
lex.MdToken.Level1, lex.MdToken.Text("Title "), lex.MdToken.BracketOpen,
lex.MdToken.Class("flyer"), lex.MdToken.BracketClose, lex.MdToken.Level2,
lex.MdToken.Text("SubTitle"), lex.MdToken.Level3, lex.MdToken.Text("Paragraph title"),
lex.MdToken.Level4, lex.MdToken.Text("Paragraph subTitle"),lex.MdToken.Text("notes")
]
```
