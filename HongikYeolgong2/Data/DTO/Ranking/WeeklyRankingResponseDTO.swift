//
//  WeeklyRankingResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import Foundation

struct WeeklyRankingResponseDTO: Decodable {
    let weekName: String
    let departmentRankings: [StudyRankingResponseDTO]
}

struct StudyRankingResponseDTO: Decodable {
    let department: String
    let studyDurationOfWeek: Int
    let currentRank: Int
    let rankChange: Int
}
