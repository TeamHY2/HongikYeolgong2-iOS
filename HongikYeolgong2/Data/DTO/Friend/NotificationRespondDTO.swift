//
//  NotificationRespondDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/29/25.
//

import Foundation

struct NotificationRespondDTO: Decodable {
    let notificationId: Int
    let type: String
    let content: String
    let receivedAt: String
    let friendId: Int
    let receiverId: Int
    let senderId: Int
    let senderNickname: String
}
