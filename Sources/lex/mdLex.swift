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

public let md_generators: [Generator<MdToken>] = [
    Generator<MdToken>(regex: "[\r\n]" , funct: { _ in nil } ),
    Generator<MdToken>(regex: "[ \ta-zA-Z0-9]+" , funct: { .Text($0) } ),
    Generator<MdToken>(regex: "#[ \t]+" , funct: { _ in .Level1 } ),
    Generator<MdToken>(regex: "##[ \t]+" , funct: { _ in .Level2 } ),
    Generator<MdToken>(regex: "###[ \t]+" , funct: { _ in .Level3 } ),
    Generator<MdToken>(regex: "####[ \t]+" , funct: { _ in .Level4 } ),
    Generator<MdToken>(regex: "\\{" , funct: { _ in .BracketOpen } ),
    Generator<MdToken>(regex: "\\}" , funct: { _ in .BracketClose } ),
    Generator<MdToken>(regex: "\\.[a-zA-Z0-9]+" , funct: { .Class(String($0.dropFirst())) } )
]

