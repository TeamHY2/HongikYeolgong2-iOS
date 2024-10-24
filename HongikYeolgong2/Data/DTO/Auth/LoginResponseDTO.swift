//
//  LoginRequestResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation

struct LoginResponseDTO: Decodable {
    let accessToken: String
    let alreadyExist: Bool
}
