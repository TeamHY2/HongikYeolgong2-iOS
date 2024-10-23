//
//  SignUpResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/23/24.
//

import Foundation

struct SignUpResponseDTO: Decodable {
    let id: Int
    let username: String
    let nickname: String
    let department: String
}
