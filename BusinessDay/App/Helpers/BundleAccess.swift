import Foundation

enum BundleKey: String {
    case firebaseConfig = "FirebaseConfig"
    case facebookWakeUrl = "FacebookWakeUrl"
    case adNativeTemplateId = "AD_NATIVE_TEMPLATE_ID"
    case adNativeBasePath = "AD_NATIVE_BASE_PATH"
    case adBasePath = "AD_BASE_PATH"
}

extension Bundle {
    func getValue(for key: BundleKey) -> String {
        // swiftlint:disable:next force_cast
        return object(forInfoDictionaryKey: key.rawValue) as! String
    }

    func getOptionalValue(for key: BundleKey) -> String? {
        return object(forInfoDictionaryKey: key.rawValue) as? String
    }
}
