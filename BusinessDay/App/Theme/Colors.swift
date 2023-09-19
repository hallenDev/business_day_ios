import UIKit

enum GrayScaleColor: String, CaseIterable {
    case black = "Black"
    case gray1 = "Gray1"
    case gray2 = "Gray2"
    case gray3 = "Gray3"
    case gray4 = "Gray4"
    case gray5 = "Gray5"
    case white = "White"
}

enum RainbowColor: String, CaseIterable {
    case thunderbird = "ThunderBird"
    case cinderella = "Cinderella"
    case broom = "Broom"
}

enum DynamicColor: String, CaseIterable {

    case brandPrimary = "BrandPrimary"
    case brandSecondary = "BrandSecondary"
    case sponsor = "Sponsor"
    case text = "Text"
    case background = "Background"
    case divider = "Divider"
    case headerDivider = "HeaderDivider"
    case quoteDivider = "QuoteDivider"
    case imageGradient = "ImageGradient"
    case secondaryButton = "SecondaryButton"
    case switchBackground = "SwitchBackground"
    case switchBorder = "SwitchBorder"
    case switchInactive = "SwitchInactive"
}

extension UIColor {
    convenience init(dynamic: DynamicColor) {
        self.init(named: dynamic.rawValue, in: .main, compatibleWith: nil)!
    }

    convenience init(grayScale: GrayScaleColor) {
        self.init(named: grayScale.rawValue, in: .main, compatibleWith: nil)!
    }

    convenience init(rainbow: RainbowColor) {
        self.init(named: rainbow.rawValue, in: .main, compatibleWith: nil)!
    }
}
