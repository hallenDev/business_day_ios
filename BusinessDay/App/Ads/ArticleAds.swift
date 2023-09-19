import Foundation
import CosmosKit
import GoogleMobileAds

enum ArticleAds: CaseIterable {
    case topBanner
    case topRelatedBanner
    case bottomRelatedBanner

    var adPlacement: AdPlacement {
        let completeBannerSizes = [GADAdSizeBanner, GADAdSizeLargeBanner, GADAdSizeMediumRectangle]
        switch self {
        case .topBanner:
            return CosmosAdPlacement(adId: "banner-1",
                                     type: .banner,
                                     featured: false,
                                     position: .below,
                                     placement: 0,
                                     sizes: completeBannerSizes)
        case .topRelatedBanner:
            return CosmosAdPlacement(adId: "banner-2",
                                     type: .banner,
                                     featured: false,
                                     position: .above,
                                     placement: 0,
                                     sizes: completeBannerSizes)
        case .bottomRelatedBanner:
            return CosmosAdPlacement(adId: "banner-3",
                                     type: .banner,
                                     featured: false,
                                     position: .below,
                                     placement: 0,
                                     sizes: completeBannerSizes)
        }
    }
}
