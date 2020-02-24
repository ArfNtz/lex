import XCTest
@testable import lex

final class lexTests: XCTestCase {

    func lexMd() {
        let source = """
        # Title {.flyer}
        ## SubTitle
        ### Paragraph title
        #### Paragraph subTitle
        notes
        """
        let tokens = lex(source)
        print(tokens)

        // what do we expect


    }

    func lex() {
        let source = """
        def foo(x, y)
        x + y * 2 + (4 + 5) / 3

        foo(3, 4)
        """
        let tokens = lex(source)
        print(tokens)

        // what do we expect
        if case .Define = tokens[0] {
            // Success
        } else {
            XCTFail("token 0 fail")
        }
        if case .Identifier(let id) = tokens[1] {
            XCTAssertEqual(id, "foo")
        } else {
            XCTFail("token 1 fail")
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
