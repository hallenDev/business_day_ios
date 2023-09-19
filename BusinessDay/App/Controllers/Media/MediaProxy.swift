import UIKit
import CosmosKit

class MediaProxy: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel = TabViewModel(viewTitle: "MEDIA",
                                     data: [TabData(title: "VIDEOS", viewController: cosmos.getVideoView(translatedTitle: nil)),
                                            TabData(title: "PODCASTS", viewController: cosmos.getAudioView(translatedTitle: nil))],
                                     maxColumnCount: 2, event: BDEvents.media)
        let controller = TabViewController.create(viewModel: viewModel)
        navigationController?.setViewControllers([controller], animated: false)
    }
}
