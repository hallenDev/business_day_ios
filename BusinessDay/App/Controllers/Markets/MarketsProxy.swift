import UIKit
import CosmosKit

class MarketsProxy: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let data = BDMarketData.allCases.map { TabData(title: $0.rawValue.uppercased(), viewController: $0.controller) }
        let columns = UIDevice.current.userInterfaceIdiom == .pad ? 3 : 0
        let viewModel = TabViewModel(viewTitle: "MARKETS",
                                     data: data,
                                     maxColumnCount: columns,
                                     event: BDEvents.markets)
        let controller = TabViewController.create(viewModel: viewModel)
        navigationController?.setViewControllers([controller], animated: false)
    }
}
