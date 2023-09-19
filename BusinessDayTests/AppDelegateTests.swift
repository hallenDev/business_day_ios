// swiftlint:disable line_length
import XCTest
@testable import BusinessDay

class AppDelegateTests: XCTestCase {

    var sut: AppDelegate!

    override func setUp() {
        sut = AppDelegate()
    }

    func testDeeplink() {

        let activity = NSUserActivity(activityType: NSUserActivityTypeBrowsingWeb)
        activity.webpageURL = URL(string: "https://www.businesslive.co.za/bd/national/2020-10-13-state-may-milk-pay-tv-operators-to-fund-sabc/")!

        let handled = sut.application(UIApplication.shared, continue: activity, restorationHandler: { _ in })

        XCTAssertTrue(handled)
    }

    func testURLSchemes_Facebookwake() {

        let url = URL(string: "business-live.facebookawake://2020-10-13-state-may-milk-pay-tv-operators-to-fund-sabc")!

        let handled = sut.application(UIApplication.shared, open: url, options: [:])

        XCTAssertTrue(handled)
    }
}
