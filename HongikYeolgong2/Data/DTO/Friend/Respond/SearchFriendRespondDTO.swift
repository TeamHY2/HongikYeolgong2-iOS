//
//  SerchFriendRespondDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/23/25.
//

import Foundation

struct SearchFriendRespondDTO: Decodable {
    let userId: Int
    let nickname: String
    let friendStatus: String
}
