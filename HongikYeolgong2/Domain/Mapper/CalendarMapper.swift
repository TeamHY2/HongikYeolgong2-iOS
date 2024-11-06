
import Foundation

extension CalendarCountAllResponseDTO {
    func toEntity() -> AllStudyRecord {
        .init(day: date.toDayofDate(), month: date.toMonthofDate(), year: date.toYearofDate(), date: date.toDate() ?? Date.now, studyCount: studyCount)
    }
}
