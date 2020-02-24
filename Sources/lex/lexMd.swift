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

typealias MdTokenGenerator = (String) -> MdToken?
let mdTokenList: [(String, MdTokenGenerator)] = [
    ("[\r\n]", { _ in nil }),
    ("[ \ta-zA-Z0-9]+", { .Text($0) }),
    ("#[ \t]+", { _ in .Level1 }),
    ("##[ \t]+", { _ in .Level2 }),
    ("###[ \t]+", { _ in .Level3 }),
    ("####[ \t]+", { _ in .Level4 }),
    ("\\{", { _ in .BracketOpen }),
    ("\\}", { _ in .BracketClose }),
    ("\\.[a-zA-Z0-9]+", { .Class(String($0.dropFirst())) })
]

public func lexMd(_ input:String) -> [MdToken] {
    var tokens = [MdToken]()
    var content = input
    
    while (content.count > 0) {
        var matched = false
        
        for (pattern, generator) in mdTokenList {
            if let m = content.match(regex: pattern) {
                if let t = generator(m) {
                    tokens.append(t)
                }
                let index = content.index(content.startIndex, offsetBy: m.count)
                content = String(content[index...])
                matched = true
                break
            }
        }
        
        if !matched {
            let index = content.index(content.startIndex, offsetBy: 1)
            let o = String(content[...index]).trimmingCharacters(in: CharacterSet.whitespaces)
            tokens.append(.Other(o))
            content =  String(content[index...])
        }
    }
    return tokens
}
