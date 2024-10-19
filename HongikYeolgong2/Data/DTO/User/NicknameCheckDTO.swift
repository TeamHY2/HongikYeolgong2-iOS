//
//  NicknameCheckDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/19/24.
//

import Foundation

struct NicknameCheckDTO: Decodable {
    let nickname: String
    let duplicate: Bool
}
