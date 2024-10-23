//
//  DurationResDTO.swift
//  HongikYeolgong2
//
//  Created by 변정훈 on 10/23/24.
//

import Foundation

struct DurationResDTO: Decodable {
    let yearHours: Int
    let yearMinutes: Int
    let monthHours: Int
    let monthMinutes: Int
    let dayHours: Int
    let dayMinutes: Int
    let semesterHours: Int
    let semesterMinutes: Int
}
