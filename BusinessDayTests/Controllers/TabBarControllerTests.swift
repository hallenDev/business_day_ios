// swiftlint:disable line_length force_cast
import XCTest
import CosmosKit
@testable import BusinessDay

class TabBarControllerTests: XCTestCase {

    var sut: TabBarController!

    override func setUp() {
        if #available(iOS 13.0, *) {
            sut = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "TabBarController")
        } else {
            sut = (UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "TabBarController") as! TabBarController)
        }
        sut.loadViewIfNeeded()
    }

    func testTabBarConfig() {

        XCTAssertNotNil(sut)

        guard let childvcs = sut.viewControllers else {
            XCTFail("Main tab bar should have 5 vc's")
            return
        }

        let childNavs = childvcs.map { $0 as? UINavigationController }

        XCTAssertEqual(childNavs.count, 5)

        // test titles & images
        XCTAssertEqual(childNavs[0]?.tabBarItem.title, "Top Stories")
        XCTAssertEqual(childNavs[0]?.tabBarItem.image?.jpegData(compressionQuality: 1), UIImage(bdName: .tabbarFeed).jpegData(compressionQuality: 1))
        XCTAssertEqual(childNavs[1]?.tabBarItem.title, "Markets")
        XCTAssertEqual(childNavs[1]?.tabBarItem.image?.jpegData(compressionQuality: 1), UIImage(bdName: .tabbarMarkets).jpegData(compressionQuality: 1))
        XCTAssertEqual(childNavs[2]?.tabBarItem.title, "Sections")
        XCTAssertEqual(childNavs[2]?.tabBarItem.image?.jpegData(compressionQuality: 1), UIImage(bdName: .tabbarSections).jpegData(compressionQuality: 1))
        XCTAssertEqual(childNavs[3]?.tabBarItem.title, "Media")
        XCTAssertEqual(childNavs[3]?.tabBarItem.image?.jpegData(compressionQuality: 1), UIImage(bdName: .tabbarMedia).jpegData(compressionQuality: 1))
        XCTAssertEqual(childNavs[4]?.tabBarItem.title, "Settings")
        XCTAssertEqual(childNavs[4]?.tabBarItem.image?.jpegData(compressionQuality: 1), UIImage(bdName: .tabbarSettings).jpegData(compressionQuality: 1))

        let children = childNavs.map { $0?.viewControllers.first }

        // test vc's before they have loaded
        XCTAssertTrue(children[0] is TopStoriesProxy)
        XCTAssertTrue(children[1] is MarketsProxy)
        XCTAssertTrue(children[2] is SectionsProxy)
        XCTAssertTrue(children[3] is MediaProxy)
        XCTAssertTrue(children[4] is ProfileProxy)

        //  load all child vc's
        children.forEach { _ = $0?.view }
        let newChildren = childNavs.map { $0?.viewControllers.first }

        // test vc's after their proxies were loaded
        XCTAssertTrue(newChildren[0] is ArticleListViewController)
        XCTAssertTrue(newChildren[1] is TabViewController)
        XCTAssertTrue(newChildren[2] is SectionViewController)
        XCTAssertTrue(newChildren[3] is TabViewController)
        XCTAssertTrue(newChildren[4] is SettingsViewController)
    }
}
