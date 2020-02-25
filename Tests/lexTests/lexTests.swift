import XCTest
@testable import lex

final class lexTests: XCTestCase {

    func markdown_t1() {

        let source = """
        # Title {.flyer}
        ## SubTitle
        ### Paragraph title
        #### Paragraph subTitle
        notes
        """
        let tokens = lex(source, md_dict)
        print(tokens)

        // what do we expect
        if case MdLexem.Level1 = tokens[0] {
            // Success
        } else {
            XCTFail("token 0 fail")
        }


    }

    func lex_t1() {
        let source = """
        bar(x, y) inf
        x + y * 8 + (4 - 1) / 7
        foo(8, 2)
        """
        let tokens = lex(source, math_dict)
        print(tokens)

        // what do we expect
        if case MathLexem.Infinite = tokens[6] {
            // Success
        } else {
            XCTFail("token 0 fail")
        }
        if case .Identifier(let id) = tokens[0] {
            XCTAssertEqual(id, "bar")
        } else {
            XCTFail("token 1 fail")
        }
    }

    static var allTests = [
        ("lex", lex_t1),
        ("markdown_t1", markdown_t1),
    ]
}
