@testable import BusinessDay
import XCTest

class TestController: UIViewController {}

class TabDataTests: XCTestCase {

    func testCreate() {

        let sut = TabData(title: "test", viewController: TestController())

        XCTAssertEqual(sut.title, "test")
        XCTAssertTrue(sut.viewController is TestController)
    }
}
