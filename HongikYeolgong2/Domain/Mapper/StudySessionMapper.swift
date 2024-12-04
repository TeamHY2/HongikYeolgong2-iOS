//
//  StudySessionMapper.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation

// StudySession에 대한 Mapper
extension WeeklyStudySessionDTO {
    func toEntity() -> WeeklyStudyRecord {
        .init(monthOfDay: date,              
              studyCount: studyCount,
              isUpcomming: date.toDateFromMonthDay() ?? .now <= .now)
    }
}
