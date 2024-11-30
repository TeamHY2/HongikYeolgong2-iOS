//
//  WeeklyRanking.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import SwiftUI

/// 랭킹뷰에서 사용하는 랭킹리스트
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

/// 개별학과 랭킹정보
struct RankingDepartment: Hashable {
    let department: String
    let studyDurationOfWeek: Int
    let currentRank: Int
    let rankChange: Int
    
    init(department: String, studyDurationOfWeek: Int, currentRank: Int, rankChange: Int) {
        self.department = department
        self.studyDurationOfWeek = studyDurationOfWeek
        self.currentRank = currentRank
        self.rankChange = rankChange
    }
    
    init() {
        self.department = "department"
        self.studyDurationOfWeek = 0
        self.currentRank = 0
        self.rankChange = 0
    }
}

extension Array where Element == RankingDepartment {
    static var initialValue: [RankingDepartment] {
        .init(repeating: .init(), count: 10)
    }
}
