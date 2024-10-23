//
//  NicknameCheckDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/19/24.
//

import Foundation

/// 닉네임체크 응답 DTO
struct NicknameCheckDTO: Decodable {
    let nickname: String
    let duplicate: Bool
}
