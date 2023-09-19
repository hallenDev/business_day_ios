import Foundation
import CosmosKit
import FirebaseAnalytics
import Reachability
import FirebaseCrashlytics

struct BDAnalytics: AnalyticsLogable {

    var reachability = try? Reachability()

    init() {
        do {
            try reachability?.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    func log(error: NSError) {
        Crashlytics.crashlytics().record(error: error)
    }

    func log(event: CosmosEvent) {
        let online = reachability?.connection != .unavailable
        Analytics.logEvent(event.name, parameters: event.parameters(online: online, cosmos: cosmos))
    }
}
