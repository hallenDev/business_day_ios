// swiftlint:disable line_length
import CosmosKit
import UIKit

enum BDFallback: FallbackConfigurable {

    case noBookmarks
    case noInternet
    case noSearchResults
    case noSectionResults
    case noArticle
    case noLive
    case media
    case markets
    case apiFailure

    var fallback: Fallback {
        switch self {
        case .noBookmarks:
            return Fallback(title: "",
                            body: "Looks like you haven’t saved anything yet. Tap on the bookmark icon in an article to save it to this section.",
                            image: UIImage(bdName: .logoDynamic))
        case .noInternet:
            return Fallback(title: "",
                            body: "The app cannot connect to the internet. Please check your connection or try again later.",
                            image: UIImage(bdName: .logoDynamic))
        case .noSearchResults:
            return Fallback(title: "NO RESULTS",
                            body: "We could not find any articles to match your search terms. Please try searching for different keywords.",
                            image: UIImage(bdName: .logoDynamic))
        default:
            return Fallback(title: "",
                            body: "We cannot retrieve the information you requested. Please try again later.",
                            image: UIImage(bdName: .logoDynamic))
        }
    }
}
