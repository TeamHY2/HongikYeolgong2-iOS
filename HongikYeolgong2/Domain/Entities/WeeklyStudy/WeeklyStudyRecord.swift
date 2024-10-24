//
//  WeeklyStudyRecord.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/25/24.
//

import Foundation

struct WeeklyStudyRecord {
    let monthOfDay: String
    let dayOfWeek: String
    let studyCount: Int
    let isUpcomming: Bool
    
    var imageName: String {
        switch studyCount {
        case 0:
            "shineCount00"
        case 1:
            "shineCount01"
        case 2:
            "shineCount02"
        case 3:
            "shineCount03"
        default:
            "shineCount00"
        }
    }
}
