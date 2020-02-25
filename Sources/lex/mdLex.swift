import Foundation

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

