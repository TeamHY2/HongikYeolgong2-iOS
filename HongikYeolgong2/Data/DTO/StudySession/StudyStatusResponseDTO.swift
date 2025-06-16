//
//  StudyStatusResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 6/16/25.
//

import Foundation

struct StudyStatusResponseDTO: Codable {
    let userId: Int
    let userName: String
    let studyDuration: String
    let studyStatus: Bool
}
