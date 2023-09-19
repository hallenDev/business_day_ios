import CosmosKit
import Foundation

enum BDEvents: CosmosEvent {

    case markets
    case media
    case podcasts
    case marketsTab
    case indicatorsTab
    case cryptoTab

    public var name: String {
        switch self {
        case .markets: return "screen_markets"
        case .media: return "screen_media"
        case .podcasts: return "screen_podcasts"
        case .marketsTab: return "screen_markets_markets"
        case .indicatorsTab: return "screen_markets_indicators"
        case .cryptoTab: return "screen_markets_crypto"
        }
    }

    func parameters(online: Bool, cosmos: Cosmos) -> [String: Any] {
        var params: [String: Any] = [:]
        switch self {
        default: break
        }
        params[CosmosEvents.Parameters.isOnline.rawValue] = online.description
        params[CosmosEvents.Parameters.isLogged.rawValue] = cosmos.isLoggedIn.description
        if let guid = cosmos.user?.guid {
            params[CosmosEvents.Parameters.guid.rawValue] = guid
        }
        return params
    }
}
