//
//  WeeklyRanking.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import Foundation

struct WeeklyRanking {
    let weekName: String
    let departmentRankings: [RankingDepartment]
    
    init(weekName: String, departmentRankings: [RankingDepartment]) {
        self.weekName = weekName
        self.departmentRankings = departmentRankings
    }
    
    init() {
        self.weekName = ""
        self.departmentRankings = []
    }
}

struct RankingDepartment {
    let department: String
    let studyDurationOfWeek: Int
    let currentRank: Int
    let rankChange: Int
}
