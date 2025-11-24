//
//  AddFriendRespondDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/24/25.
//

import Foundation

struct AddFriendRespondDTO: Decodable {
    let id: Int
    let receiverId: Int
    let friendStatus: String
}
