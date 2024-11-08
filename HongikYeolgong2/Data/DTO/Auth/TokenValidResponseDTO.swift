//
//  TokenValidResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/6/24.
//

import Foundation

struct TokenValidResponseDTO: Decodable {
    let role: String
    let validToken: Bool
}
