//
//  ASTokenResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/11/24.
//

import Foundation

struct ASTokenResponseDTO: Decodable {
    let access_token: String
    let expires_in: Int
    let id_token: String
    let refresh_token: String
    let token_type: String        
}

