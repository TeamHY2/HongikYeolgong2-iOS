//
//  ASRevokeTokenRequestDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/12/24.
//

import Foundation

struct ASRevokeTokenRequestDTO {
    let client_id: String
    let client_secret: String
    let token: String
    let token_type_hint: String
}
