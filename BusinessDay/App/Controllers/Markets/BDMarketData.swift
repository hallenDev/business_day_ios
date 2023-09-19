import Foundation
import UIKit
import CosmosKit

enum BDMarketData: String, CaseIterable {

    case markets
    case indicators
    case crypto

    var controller: UIViewController {
        switch self {
        case .markets:
            let viewmodel = WidgetStackViewModel(widgets: [WebViewModel(url: WebData.markets.url, type: .url),
                                                           WebViewModel(url: WebData.top5UpDown.url, type: .url)],
                                                 renderType: .live,
                                                 fallback: BDFallback.apiFailure.fallback,
                                                 event: BDEvents.marketsTab,
                                                 forceLightMode: true)
            return cosmos.getWidgetStackViewController(viewModel: viewmodel)
        case .indicators:
            let viewmodel = WidgetStackViewModel(widgets: [WebViewModel(url: WebData.performanceData.url, type: .url),
                                                           WebViewModel(url: WebData.jseIndices.url, type: .url),
                                                           WebViewModel(url: WebData.marketsAndIndicators.url, type: .url)],
                                                 renderType: .live,
                                                 fallback: BDFallback.apiFailure.fallback,
                                                 event: BDEvents.indicatorsTab,
                                                 forceLightMode: true)
            return cosmos.getWidgetStackViewController(viewModel: viewmodel)
        case .crypto:
            let viewmodel = WidgetStackViewModel(widgets: [WebViewModel(url: WebData.crypto.url, type: .url)],
                                                 renderType: .live,
                                                 fallback: BDFallback.apiFailure.fallback,
                                                 event: BDEvents.cryptoTab,
                                                 forceLightMode: true)
            return cosmos.getWidgetStackViewController(viewModel: viewmodel)
        }
    }

    enum WebData: String {
        case markets = "Markets"
        case top5UpDown = "Top5UpDown"
        case performanceData = "PerformanceData"
        case jseIndices = "JSEIndices"
        case marketsAndIndicators = "MarketsandIndicators"
        case crypto = "Cryptocurrencies"

        var url: URL {
            let base = "https://www.profiledata.co.za/brokersites/businesslive/Scripts/Home/LandingComponents/"
            return URL(string: String(format: "%@%@.aspx", base, self.rawValue))!
        }
    }
}
