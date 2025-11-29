//
//  FriendsTimeListRespondDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/25/25.
//

import Foundation

struct FriendsTimeListRespondDTO: Codable {
    let userId: Int
    let friendId: Int
    let friendNickname: String
    let studyTime: String
}
