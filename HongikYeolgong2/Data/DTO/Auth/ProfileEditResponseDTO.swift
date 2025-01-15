//
//  ProfileEditResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/14/25.
//

import Foundation

struct ProfileEditResponseDTO: Decodable {
    let id: Int
    let username: String
    let nickname: String
    let department: String
}
