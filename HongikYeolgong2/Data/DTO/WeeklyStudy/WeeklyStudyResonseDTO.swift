//
//  WeelyStudyResonseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation

struct WeeklyStudyResonseDTO: Decodable {
    let id: Int
    let year: Int
    let weekName: String
    let weekNumber: Int
}
