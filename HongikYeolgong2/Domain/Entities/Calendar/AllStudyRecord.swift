
import Foundation

struct AllStudyRecord {
    let day: String
    let month: String
    let year: String
    let date: Date
    let studyCount: Int
    
    var imageName: String {
        switch studyCount {
        case 0:
            "day_Count00"
        case 1:
            "day_Count01"
        case 2:
            "day_Count02"
        default:
            "day_Count03"
        }
    }
}


