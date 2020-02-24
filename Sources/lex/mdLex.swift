import Foundation

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

