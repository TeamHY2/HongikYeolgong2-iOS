//
//  StudySessionResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/28/24.
//

import Foundation

struct StudySessionResponseDTO: Decodable {
    let id: Int
    let userId: Int
    let startTime: String
    let endTime: String
}
