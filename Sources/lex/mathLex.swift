import Foundation

public enum MathToken {
    case Define
    case Identifier(String)
    case Number(Float)
    case ParensOpen
    case ParensClose
    case Comma
    case Other(String)
    case BinaryOp(String)
}

public let math_gens: [Gen<MathToken>] = [
    Gen<MathToken>(regex: "[ \t\n]" , funct: { _ in nil } ),
    Gen<MathToken>(regex: "[a-zA-Z][a-zA-Z0-9]*" , funct: { $0 == "def" ? .Define : .Identifier($0) } ),
    Gen<MathToken>(regex: "#[0-9.]+" , funct: {(r: String) in .Number((r as NSString).floatValue) } ),
    Gen<MathToken>(regex: "\\(" , funct: { _ in .ParensOpen } ),
    Gen<MathToken>(regex: "\\)" , funct: { _ in .ParensClose } ),
    Gen<MathToken>(regex: "," , funct: { _ in .Comma } ),
    Gen<MathToken>(regex: "[+\\-*/]" , funct: { .BinaryOp($0) } )
]

