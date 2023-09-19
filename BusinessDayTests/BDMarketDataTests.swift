// swiftlint:disable line_length
@testable import BusinessDay
import XCTest
import CosmosKit

class BDMarketDataTests: XCTestCase {

    func testCreate() {

        for market in BDMarketData.allCases {
            switch market {
            case .markets, .indicators, .crypto:
                XCTAssertTrue(market.controller is WidgetStackViewController)
            }
        }
    }

    func testCreateWebData() {

        XCTAssertEqual(BDMarketData.WebData.markets.url.absoluteString, "https://www.profiledata.co.za/brokersites/businesslive/Scripts/Home/LandingComponents/Markets.aspx")
        XCTAssertEqual(BDMarketData.WebData.top5UpDown.url.absoluteString, "https://www.profiledata.co.za/brokersites/businesslive/Scripts/Home/LandingComponents/Top5UpDown.aspx")
        XCTAssertEqual(BDMarketData.WebData.performanceData.url.absoluteString, "https://www.profiledata.co.za/brokersites/businesslive/Scripts/Home/LandingComponents/PerformanceData.aspx")
        XCTAssertEqual(BDMarketData.WebData.jseIndices.url.absoluteString, "https://www.profiledata.co.za/brokersites/businesslive/Scripts/Home/LandingComponents/JSEIndices.aspx")
        XCTAssertEqual(BDMarketData.WebData.marketsAndIndicators.url.absoluteString, "https://www.profiledata.co.za/brokersites/businesslive/Scripts/Home/LandingComponents/MarketsandIndicators.aspx")
        XCTAssertEqual(BDMarketData.WebData.crypto.url.absoluteString, "https://www.profiledata.co.za/brokersites/businesslive/Scripts/Home/LandingComponents/Cryptocurrencies.aspx")
    }
}
