//
//  FriendRespondDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/22/25.
//

import Foundation

struct FriendRespondDTO: Encodable {
    let notificationId: Int
    let friendId: Int
    let senderId: Int
    let friendStatus: String
}
