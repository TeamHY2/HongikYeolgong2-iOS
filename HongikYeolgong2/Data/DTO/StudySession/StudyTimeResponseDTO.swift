//
//  StudyDurationResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/6/24.
//

import Foundation

struct StudyTimeResponseDTO: Decodable {
    let yearHours: Int
    let yearMinutes: Int
    let monthHours: Int
    let monthMinutes: Int
    let dayHours: Int
    let dayMinutes: Int
}
