import Foundation

public struct Generator<T> {
    var regex: String
    var funct: (String) -> T?
}

public func lex<T>(_ input:String,_ generators:[Generator<T>]) -> [T] {
    var tokens = [T]()
    var content = input

    while (content.count > 0) {
        var matched = false
        
        for g in generators {
            if let m = content.match(regex: g.regex) {
                if let t = g.funct(m) {
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
            content =  String(content[index...])
        }
    }
    return tokens
}
