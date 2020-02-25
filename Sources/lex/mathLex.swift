import Foundation

// langage elements
public enum MathLexem : Equatable {
    case Infinite
    case Identifier(String)
    case Number(Float)
    case ParensOpen
    case ParensClose
    case Comma
    case BinaryOp(String)
}

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

