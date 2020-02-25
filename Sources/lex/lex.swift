import Foundation

// A defition
public struct Def<T> {
    var regex: String
    var funct: (String) -> T?
}

// Take some text and return dictionary elements
public func lex<T>(_ someText:String,_ dict:[Def<T>]) -> [T] {
    var lexems = [T]()
    var content = someText
    while (content.count > 0) {
        var found = false
        for def in dict {
            if let r = content.range(of: "^"+def.regex, options: .regularExpression) {
                let m = String(content[r])
                if let t = def.funct(m) {
                    lexems.append(t)
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
    return lexems
}
