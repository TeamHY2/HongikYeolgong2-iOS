//
//  WeeklyStudyRecord.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/25/24.
//

import Foundation

struct WeeklyStudyRecord {
    let monthOfDay: String    
    var studyCount: Int
    let isUpcomming: Bool
    
    var imageName: String {
        switch studyCount {
        case 0:
            "shineCount00"
        case 1:
            "shineCount01"
        case 2:
            "shineCount02"
        default:
            "shineCount03"
        }
    }
}

extension Array where Element == WeeklyStudyRecord {
    static var initialValue: [WeeklyStudyRecord] {
        .init(repeating: .init(monthOfDay: "11/11", studyCount: 1, isUpcomming: false), count: 7)
    }
}
