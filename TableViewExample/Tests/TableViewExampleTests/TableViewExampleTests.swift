import XCTest
@testable import TableViewExample

final class TableViewExampleTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(ScreenTableViewExample().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
