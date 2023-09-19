import UIKit
import CosmosKit

class TopStoriesProxy: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setViewControllers([cosmos.getLiveView()], animated: false)
    }
}

class SectionsProxy: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setViewControllers([cosmos.getSectionView(renderType: .live)], animated: false)
    }
}

class ProfileProxy: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setViewControllers([cosmos.getSettingsView()], animated: false)
    }
}
