import Foundation

public struct Gen<T> {
    var regex: String
    var funct: (String) -> T?
}

public func lex<T>(_ someText:String,_ gens:[Gen<T>]) -> [T] {
    var tokens = [T]()
    var content = someText
    while (content.count > 0) {
        var found = false
        for g in gens {
            if let r = content.range(of: "^"+g.regex, options: .regularExpression) {
                let m = String(content[r])
                if let t = g.funct(m) {
                    tokens.append(t)
                }
                let index = content.index(content.startIndex, offsetBy: m.count)
                content = String(content[index...])
                found = true
                break
            }
        }
        if !found {
            let index = content.index(content.startIndex, offsetBy: 1)
            content =  String(content[index...])
        }
    }
    return tokens
}
