//
//  updateTokenResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 3/23/25.
//

import Foundation

struct UpdateTokenResponseDTO: Decodable {
    let id: Int
    let username: String
    let nickname: String
    let deviceToken: String
}
