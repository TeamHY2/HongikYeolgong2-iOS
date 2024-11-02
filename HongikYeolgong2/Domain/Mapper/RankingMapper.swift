//
//  RankingMapper.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import Foundation

extension WeeklyRankingResponseDTO {
    func toEntity() -> WeeklyRanking {
        .init(weekName: weekName,
              departmentRankings: departmentRankings.map { $0.toEntity() })
    }
}

extension StudyRankingResponseDTO {
    func toEntity() -> RankingDepartment {
        .init(department: department,
              studyDurationOfWeek: studyDurationOfWeek,
              currentRank: currentRank,
              rankChange: rankChange)
    }
}
