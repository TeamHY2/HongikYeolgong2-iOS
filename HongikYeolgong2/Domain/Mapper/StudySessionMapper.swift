//
//  StudySessionMapper.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation

extension WeeklyStudySessionDTO {
    func toEntity() -> StudyRoomUsage {
        .init(monthOfDay: date.toMonthOfDay(),
              dayOfWeek: date.toDayOfWeek(),
              studyCount: studyCount,
              isUpcomming: date.toDate() ?? .now <= .now)
    }
}
