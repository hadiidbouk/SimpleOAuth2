import XCTest
@testable import SimpleOAuth2

final class SimpleOAuth2Tests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SimpleOAuth2().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
