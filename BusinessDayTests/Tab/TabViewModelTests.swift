// swiftlint:disable line_length
@testable import BusinessDay
import XCTest

class TabViewModelTests: XCTestCase {

    func testCreate() {

        let sut = TabViewModel(viewTitle: "test", data: [TabData(title: "test1", viewController: TestController()), TabData(title: "test2", viewController: TestController())], event: BDEvents.cryptoTab)

        XCTAssertEqual(sut.title, "test")
        XCTAssertEqual(sut.numberOfItems(), 2)
        XCTAssertEqual(sut.item(at: IndexPath(row: 0, section: 0))?.title, "test1")
        XCTAssertEqual(sut.item(at: IndexPath(row: 1, section: 0))?.title, "test2")
        XCTAssertEqual(sut.item(at: IndexPath(row: 0, section: 1))?.title, "test1")
        XCTAssertNil(sut.item(at: IndexPath(row: 3, section: 0))?.title)
    }
}
