//
//  ASTokenRequestDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/11/24.
//

import Foundation

struct ASTokenRequestDTO: Encodable {
    let client_id: String
    let client_secret: String
    let grant_type: String
    let code: String
    var refresh_token: String?
    var redirect_uri: String?
}
