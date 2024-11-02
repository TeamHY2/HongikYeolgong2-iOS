//
//  WeeklyRankingResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import Foundation

/// 전체 랭킹데이터 응답 DTO
struct WeeklyRankingResponseDTO: Decodable {
    let weekName: String
    let departmentRankings: [StudyRankingResponseDTO]
}

/// 개별학과 응답 DTO
struct StudyRankingResponseDTO: Decodable {
    let department: String
    let studyDurationOfWeek: Int
    let currentRank: Int
    let rankChange: Int
}
