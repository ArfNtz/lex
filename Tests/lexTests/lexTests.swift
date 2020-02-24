import XCTest
@testable import lex

final class lexTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(lex().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
