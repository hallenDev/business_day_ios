import UIKit
import CosmosKit

class MediaProxy: UIViewController {

    // swiftlint:disable:next line_length
    private let ionoHTML = "<iframe src=\"https://iframe.iono.fm/p/308\" width=\"100%\" height=\"400\" frameborder=\"0\"><a href=\"http://iono.fm/p/308\">Content hosted by iono.fm</a></iframe>"

    override func viewDidLoad() {
        super.viewDidLoad()
        let data = IonoWidgetData(html: ionoHTML, provider: "http://iono.fm/")
        let widget = IonoViewModel(from: data)
        let podcastVC = cosmos.getWidgetStackViewController(widgets: [widget], forceLightMode: true)
        let viewModel = TabViewModel(viewTitle: "MEDIA",
                                     data: [TabData(title: "VIDEOS", viewController: cosmos.getVideoView(title: nil)),
                                            TabData(title: "PODCASTS", viewController: podcastVC)],
                                     maxColumnCount: 2)
        let controller = TabViewController.create(viewModel: viewModel)
        navigationController?.setViewControllers([controller], animated: false)
    }
}
