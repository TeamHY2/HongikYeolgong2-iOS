//
//  WithdrawResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/9/24.
//

import Foundation

struct WithdrawResponseDTO: Decodable {
    let id: Int
    let username: String
    let nickname: String
    let department: String    
}
