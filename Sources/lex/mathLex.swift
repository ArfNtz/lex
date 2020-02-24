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

public let math_generators: [Generator<MathToken>] = [
    Generator<MathToken>(regex: "[ \t\n]" , funct: { _ in nil } ),
    Generator<MathToken>(regex: "[a-zA-Z][a-zA-Z0-9]*" , funct: { $0 == "def" ? .Define : .Identifier($0) } ),
    Generator<MathToken>(regex: "#[0-9.]+" , funct: {(r: String) in .Number((r as NSString).floatValue) } ),
    Generator<MathToken>(regex: "\\(" , funct: { _ in .ParensOpen } ),
    Generator<MathToken>(regex: "\\)" , funct: { _ in .ParensClose } ),
    Generator<MathToken>(regex: "," , funct: { _ in .Comma } ),
    Generator<MathToken>(regex: "[+\\-*/]" , funct: { .BinaryOp($0) } )
]

