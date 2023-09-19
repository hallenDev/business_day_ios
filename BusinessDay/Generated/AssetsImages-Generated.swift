// •••••••••••••••••••••••••••••••••••••••••••••••••••••
// • GENERATED FILE                                    •
// •••••••••••••••••••••••••••••••••••••••••••••••••••••

// • Assets
import UIKit

public enum AssetsImages: String, CaseIterable {

    public enum Cells: String, CaseIterable {
        case labelPremium = "label-Premium"
        case labelSponsored = "label-Sponsored"
        case videoIcon
    }

    public enum Fallbacks: String, CaseIterable {
        case fallbackBookmarks = "fallback-Bookmarks"
        case fallbackNoNet = "fallback-NoNet"
        case fallbackSearch = "fallback-Search"
        case fallbackSections = "fallback-Sections"
    }

    public enum Logos: String, CaseIterable {
        case logoDynamic = "logo-Dynamic"
        case logoWhite = "logo-White"
    }

    public enum TabBar: String, CaseIterable {
        case tabbarFeed = "tabbar-Feed"
        case tabbarMarkets = "tabbar-Markets"
        case tabbarMedia = "tabbar-Media"
        case tabbarSections = "tabbar-Sections"
        case tabbarSettings = "tabbar-Settings"
    }
    case iTunesArtwork

    static let bundle: Bundle = Bundle(identifier: "com.bdfm.ipad")!
}

extension UIImage {
    public  convenience init(bdName name: AssetsImages) {
        self.init(named: name.rawValue, in: AssetsImages.bundle, compatibleWith: nil)!
    }
    public  convenience init(bdName name: AssetsImages.Cells) {
        self.init(named: name.rawValue, in: AssetsImages.bundle, compatibleWith: nil)!
    }
    public  convenience init(bdName name: AssetsImages.Fallbacks) {
        self.init(named: name.rawValue, in: AssetsImages.bundle, compatibleWith: nil)!
    }
    public  convenience init(bdName name: AssetsImages.Logos) {
        self.init(named: name.rawValue, in: AssetsImages.bundle, compatibleWith: nil)!
    }
    public  convenience init(bdName name: AssetsImages.TabBar) {
        self.init(named: name.rawValue, in: AssetsImages.bundle, compatibleWith: nil)!
    }
}
