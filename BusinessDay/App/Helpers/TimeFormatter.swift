import Foundation
import CosmosKit

struct TimeFormatter {

    static func timeAgoString(for date: Date) -> String? {
        CosmosTimeFormatter.timeAgo(for: date, shortened: true)
    }

    static func isFresh(date: Date) -> Bool {
        let dateDiff = Calendar.current.dateComponents(
            [.hour],
            from: date, to: Date())
        return (dateDiff.hour ?? 13) <= 12
    }
}
