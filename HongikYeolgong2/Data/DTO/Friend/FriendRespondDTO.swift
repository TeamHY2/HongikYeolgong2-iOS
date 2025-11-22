//
//  FriendRespondDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/22/25.
//

import Foundation

struct FriendRespondDTO: Encodable {
    let senderId: Int
    let isAccepted: String
    
    init(senderId: Int, isAccepted: Bool) {
        self.senderId = senderId
        self.isAccepted = isAccepted ? "ACCEPTED" : "REJECTED"
    }
}
