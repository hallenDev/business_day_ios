import UIKit
import Firebase
import CosmosKit
import AppTrackingTransparency
import AdSupport
import Chartbeat

var cosmos: Cosmos!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // swiftlint:disable:next line_length
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ThemeBuilder.importFonts()
        setupFireBase()
        setupChartbeat()
        setupCosmos()
        configurePushNotifications(application: application, options: launchOptions)

        NotificationCenter.default.addObserver(self, selector: #selector(self.loadedArticle(notification:)), name: Notification.Name(Cosmos.Notification.articleLoaded.rawValue), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.exitedArticle(notification:)), name: Notification.Name(Cosmos.Notification.articleExited.rawValue), object: nil)

        return true
    }

    // MARK: Cosmos Setup

    // TODO: move this into cosmos on next release
    private func setupTracking() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { _ in })
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        setupTracking()
    }

    fileprivate func setupCosmos() {

        let config = CosmosConfig(publication: Publications.businessDay,
                                  customArticlePublications: Publications.allCases,
                                  customRelatedPublications: Publications.allCases,
                                  filteredPublications: Publications.filteredPubs)

        cosmos = Cosmos(apiConfig: config,
                        logger: BDAnalytics(),
                        errorDelegate: nil,
                        eventDelegate: nil)
    }

    // MARK: Firebase Setup

    fileprivate func setupFireBase() {
        guard let firebaseConfig = Bundle.main.getOptionalValue(for: .firebaseConfig),
              let path = Bundle.main.path(forResource: firebaseConfig, ofType: "plist"),
              let options = FirebaseOptions(contentsOfFile: path) else {
            FirebaseApp.configure()
            return
        }
        FirebaseApp.configure(options: options)
    }

    private func setupChartbeat() {
        CBTracker.shared().debugMode = true
        CBTracker.shared().logLevel = .debug
        CBTracker.shared().setupTracker(withAccountId: Int32(Constants.Chartbeat.accountId), domain: Constants.Chartbeat.domain)
    }

    // MARK: Deep Linking

    // swiftlint:disable:next line_length
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL,
            let slug = url.pathComponents.last {
            cosmos.showArticleFromSlug(slug: slug,
                                       renderType: .pushNotification(render: .live))
        }
        return true
    }

    // MARK: Custom URL Schemes

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if url.absoluteString.starts(with: Bundle.main.getValue(for: .facebookWakeUrl)), let host = url.host {
            cosmos.showArticleFromSlug(slug: host,
                                       renderType: .pushNotification(render: .live))
            return true
        }
        return false
    }

    @objc func loadedArticle(notification: Notification) {

        if cosmos.user == nil {
            CBTracker.shared().setUserAnonymous()
        } else {
            CBTracker.shared().setUserLoggedIn()
        }

        guard notification.userInfo != nil, let userInfo = notification.userInfo as? [String: Any] else {
            return
        }

        let view = userInfo["view"]
        guard let url = userInfo["url"] as? String else {
            return
        }

        guard let title = userInfo["title"] as? String else {
            return
        }

        guard let author = userInfo["author"] as? String else {
            return
        }

        CBTracker.shared().authors = [author]
        CBTracker.shared().trackView(
            view,
            viewId: "https://\(Constants.Chartbeat.domain)\(url)",
            title: title
        )

    }

    @objc func exitedArticle(notification: Notification) {
        CBTracker.shared().stop()
    }
}

// MARK: Firebase messaging delegate & Notification Center delegate
extension AppDelegate: MessagingDelegate, UNUserNotificationCenterDelegate {

    // MARK: Push Notification

    fileprivate func configurePushNotifications(application: UIApplication, options: [UIApplication.LaunchOptionsKey: Any]?) {
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: {_, _ in
            cosmos.runPushNotificationMigration(override: true)
        })
        application.registerForRemoteNotifications()

        if let push = options?[.remoteNotification] as? [String: Any] {
            cosmos.showPushNotification(for: push)
        }
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        cosmos.pushNotifications.registeredForNotifications(with: deviceToken)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        cosmos.showPushNotification(for: userInfo)
    }
}
