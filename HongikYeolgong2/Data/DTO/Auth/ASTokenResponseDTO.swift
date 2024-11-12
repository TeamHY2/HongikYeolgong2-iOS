//
//  ASTokenResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/11/24.
//

import Foundation

struct ASTokenResponseDTO: Decodable {
    let accessToken: String
    let expiresIn: Int
    let idToken: String
    let refreshToken: String
    let tokenType: String
}

