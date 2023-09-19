import XCTest
@testable import BusinessDay

class AssetsImagesTests: XCTestCase {

    func testLoadingOfAllImages() {

        for image in AssetsImages.allCases {
            XCTAssertNotNil(UIImage(bdName: image), "Could not load : \(image)")
        }

        for image in AssetsImages.Cells.allCases {
            XCTAssertNotNil(UIImage(bdName: image), "Could not load : \(image)")
        }

        for image in AssetsImages.Fallbacks.allCases {
            XCTAssertNotNil(UIImage(bdName: image), "Could not load : \(image)")
        }

        for image in AssetsImages.Logos.allCases {
            XCTAssertNotNil(UIImage(bdName: image), "Could not load : \(image)")
        }

        for image in AssetsImages.TabBar.allCases {
            XCTAssertNotNil(UIImage(bdName: image), "Could not load : \(image)")
        }

    }
}
