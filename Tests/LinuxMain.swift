import XCTest

import lexTests

var tests = [XCTestCaseEntry]()
tests += lexTests.allTests()
XCTMain(tests)
