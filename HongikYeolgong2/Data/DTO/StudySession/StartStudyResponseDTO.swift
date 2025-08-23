//
//  StartStudyResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 6/21/25.
//

import Foundation

struct StartStudyResponseDTO: Codable {
    let studySessionId: Int
    let userId: Int
    let startTime: String
}
