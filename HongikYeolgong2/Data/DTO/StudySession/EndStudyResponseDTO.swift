//
//  EndStudyResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 6/21/25.
//

import Foundation

struct EndStudyResponseDTO: Codable {
    let studySessionId: Int
    let userId: Int
    let endTime: String
}
