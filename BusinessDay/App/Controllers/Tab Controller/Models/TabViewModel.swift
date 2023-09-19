import Foundation
import CosmosKit

struct TabViewModel {
    let data: [TabData]
    let title: String
    let maxColumnCount: Int
    let event: CosmosEvent

    init(viewTitle: String, data: [TabData], maxColumnCount: Int = 0, event: CosmosEvent) {
        self.data = data
        self.title = viewTitle
        self.maxColumnCount = maxColumnCount
        self.event = event
    }

    func viewControllers() -> [UIViewController] {
        data.map { $0.viewController }
    }

    func views() -> [UIView] {
        data.map { $0.viewController.view }
    }

    func numberOfItems() -> Int {
        data.count
    }

    func item(at indexPath: IndexPath) -> TabData? {
        guard 0..<numberOfItems() ~= indexPath.row else { return nil }
        return data[indexPath.row]
    }
}
