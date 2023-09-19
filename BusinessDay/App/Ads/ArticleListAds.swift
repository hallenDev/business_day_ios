import Foundation
import CosmosKit
import GoogleMobileAds

enum ArticleListAds: CaseIterable {
    case banner1
    case banner2
    case banner3
    case interscroller

    func adPlacement(pub: Publications) -> AdPlacement {
        let completeBannerSizes = [GADAdSizeBanner, GADAdSizeLargeBanner, GADAdSizeMediumRectangle]
        switch self {
        case .banner1:
            return CosmosAdPlacement(adId: "banner-1",
                                     type: .banner,
                                     featured: true,
                                     position: .below,
                                     placement: 0,
                                     sizes: completeBannerSizes)
        case .banner2:
            return CosmosAdPlacement(adId: "banner-2",
                                     type: .banner,
                                     featured: false,
                                     position: .below,
                                     placement: 3,
                                     sizes: completeBannerSizes)
        case .banner3:
            return CosmosAdPlacement(adId: "banner-3",
                                     type: .banner,
                                     featured: true,
                                     position: .below,
                                     placement: 7,
                                     sizes: completeBannerSizes)
        case .interscroller:
            let templateId = Bundle.main.getValue(for: .adNativeTemplateId)
            var adPath = Bundle.main.getOptionalValue(for: .adNativeBasePath)

            if adPath?.isEmpty ?? true {
                adPath = nil
            }

            return CosmosNativeAdPlacement(templateIds: [templateId],
                                           adId: "native-interscroller",
                                           customPath: adPath,
                                           type: .interscroller,
                                           featured: false,
                                           position: .below,
                                           placement: 10,
                                           sizes: [GADAdSize(size: CGSize(width: 375, height: 300), flags: 0)])

        }
    }
}
