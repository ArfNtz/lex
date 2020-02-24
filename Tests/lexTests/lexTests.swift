import XCTest
@testable import lex

final class lexTests: XCTestCase {
    func testExample() {

        func multiline(_ x: String...) -> String {
            return x.joined(separator: "\n")
        }

        let source = multiline(
            "def foo(x, y)",
            "  x + y * 2 + (4 + 5) / 3",
            "",
            "foo(3, 4)"
        )

        let lexer = Lexer(input: source)
        let tokens = lexer.tokenize()
        print(tokens)
        
        // XCTAssertEqual(lex().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
