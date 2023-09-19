import Foundation
import CosmosKit
import GoogleMobileAds

enum Publications: CaseIterable, Publication {
    case businessDay

    static let filteredPubs = [
        FilteredPublication(id: "bl"),
        FilteredPublication(id: "bt"),
        FilteredPublication(id: "fm"),
        FilteredPublication(id: "ft"),
        FilteredPublication(id: "rdm"),
        FilteredPublication(id: "bdtv"),
        FilteredPublication(id: "redzone")
    ]

    var facebookClientId: String? { "52461773fc725fecc084fab37eab3638" }

    var facebookAppId: String? { "356832828965047" }

    var consumerKey: String { "0c5d3e2ae365c6aecc61cf71a75971451861840d" }
    
    var consumerSecret: String { "bbace0453dcba0bda8c67823f607fb9475588008"}

    var mapsApiKey: String { "AIzaSyAgPd1lHLX7HVBgBjLY1gxj-CdSgBAw5ck" }

    var stagingDomain: String { "https://www.businesslive.co.za" }

    var liveDomain: String { "https://www.businesslive.co.za" }

    var id: String { "bd" }

    var name: String { "Business Day" }

    var isEdition: Bool { false }

    var loadingIndicator: LoadingIndicatorConfig? {
        LoadingIndicatorConfig(lightMode: "loader-light", darkMode: "loader-dark")
    }

    var authConfig: AuthConfig? {
        AuthConfig(signInOptions: "Already registered on BusinessLIVE, TimesLIVE or SowetanLIVE? Sign in with the same details.",
                   registerInstructions: "Use your email address to register. We’ll email you to verify your account.",
                   registerOptions: "Already have a BusinessLIVE, TimesLIVE or SowetanLIVE account?",
                   registerAuthBlock: "",
                   forgotPasswordEmailInstructions: "We’ll email you instructions to reset your password.")
    }

    var settingsConfig: SettingsConfig {
        let pushTopics = [PushNotificationConfig.PushTopic(id: "breaking_news", name: "Breaking news"),
                          PushNotificationConfig.PushTopic(id: "current_affairs", name: "Current affairs"),
                          PushNotificationConfig.PushTopic(id: "markets", name: "Markets"),
                          PushNotificationConfig.PushTopic(id: "opinion", name: "Opinion"),
                          PushNotificationConfig.PushTopic(id: "companies", name: "Companies")]

        let config = SettingsConfig(
            aboutUsSlug: "native-app-about-business-day",
            contactUsSlug: "2020-09-28-contact-business-day",
            accountContent: [.account, .bookmarks]        ,
            pushNotificationConfig: PushNotificationConfig(info: "Be the first to know about breaking news, must-read topics and special offers from \(name)",
                                                           topics: pushTopics),
            newslettersConfig: NewslettersConfig(info: "A selection of the best news, comment and insight from \(name)."))
        return config
    }

    var commentConfig: CommentProvider {
        DisqusConfig(shortname: "business-live",
                     domain: "https://www.businesslive.co.za",
                     apiKey: "KpZwCAqMumFeEO6uhTebReqsYYYKeo8m1970185hruuB29u3gvrhYOTG21yaTH7w")
    }

    var narratiiveConfig: NarratiiveConfig {
        NarratiiveConfig(baseUrl: "https://collector.effectivemeasure.net/app",
                         host: "m-businessday.co.za",
                         hostKey: "aBT9SznO/A4iLXeVtRClHX2/gqc=")
    }

    var adConfig: AdConfig? {
        let pager = CosmosAdPlacement(adId: "banner-1",
                                      type: .banner,
                                      featured: false,
                                      position: .below,
                                      placement: 5,
                                      sizes: [GADAdSizeMediumRectangle])

        let pagerStatic = CosmosAdPlacement(adId: "banner-2",
                                      type: .banner,
                                      featured: false,
                                      position: .below,
                                      placement: 2,
                                      sizes: [GADAdSizeMediumRectangle])
        return AdConfig(base: Bundle.main.getValue(for: .adBasePath),
                        articleListPlacements: ArticleListAds.allCases.map { $0.adPlacement(pub: self) },
                        articlePlacements: ArticleAds.allCases.map { $0.adPlacement },
                        articlePagerInitialPlacement: pagerStatic,
                        articlePagerPlacement: pager)
    }
    var editionConfig: EditionConfig? { nil }

    var fallbackConfig: FallbackConfig {
        FallbackConfig(noNetworkFallback: BDFallback.noInternet,
                       apiErrorFallback: BDFallback.apiFailure,
                       articleFallback: BDFallback.noArticle,
                       searchFallback: BDFallback.noSearchResults,
                       sectionFallback: BDFallback.noSectionResults,
                       bookmarksFallback: BDFallback.noBookmarks,
                       articleListFallback: BDFallback.noLive)
    }

    var theme: Theme {
        ThemeBuilder().build(self).applyLocalTheme()
    }

    var uiConfig: CosmosUIConfig {
        CosmosUIConfig(logo: self.logo,
                       articleLogo: UIImage(bdName: .logoDynamic),
                       shouldNavHideLogo: true,
                       registrationWallView: RegistrationWallView.nib(),
                       subscriptionWallView: SubscriptionWallView.nib(),
                       payWallView: SubscriptionWallView.nib(),
                       featuredArticleCell: BDFeaturedArticleCell.uiPair,
                       articleCell: BDArticleCell.uiPair,
                       relatedArticleType: .injected,
                       relatedArticle: BDRelatedView.nib(),
                       articleHeaderType: .injected,
                       articleHeader: BDArticleHeader.nib())
    }

    var logo: UIImage { UIImage(bdName: .logoWhite) }
}
