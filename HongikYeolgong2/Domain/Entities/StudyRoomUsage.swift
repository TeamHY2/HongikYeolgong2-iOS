import Foundation

struct Day: Identifiable {
    var id = UUID().uuidString
    let dayOfNumber: String
    var usageRecord: [StudyRoomUsage] = []
    
    var todayUsageCount: Int {
        return usageRecord.count
    }
}

struct StudyRoomUsage {
    var id: String = UUID().uuidString
    let date: Date
    let duration: Double
}

enum MoveType {
    case current
    case next
    case prev
}
