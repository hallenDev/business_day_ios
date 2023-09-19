@testable import BusinessDay
import XCTest

class ColorTests: XCTestCase {

    func testAllDynamicColorsLoadFromCatalog() {
        let allKnownColors = DynamicColor.allCases
        for name in allKnownColors {
            XCTAssertNotNil(UIColor(named: name.rawValue, in: .main, compatibleWith: nil), "Missing color in asset catalog named \(name)")
        }
    }

    func testAllGrayScaleColorsLoadFromCatalog() {
        let allKnownColors = GrayScaleColor.allCases
        for name in allKnownColors {
            XCTAssertNotNil(UIColor(named: name.rawValue, in: .main, compatibleWith: nil), "Missing color in asset catalog named \(name)")
        }
    }

    func testAllRainbowColorsLoadFromCatalog() {
        let allKnownColors = RainbowColor.allCases
        for name in allKnownColors {
            XCTAssertNotNil(UIColor(named: name.rawValue, in: .main, compatibleWith: nil), "Missing color in asset catalog named \(name)")
        }
    }
}
