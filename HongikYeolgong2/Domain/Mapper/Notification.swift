//
//  Notification.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/29/25.
//

import Foundation

enum NotificationType: String {
    case friendRequest = "REQUEST"
    case friendAccepted = "ACCEPTED"
    case exception
}

struct Notification: Hashable {
    let notificationId: Int
    let type: NotificationType
    let content: String
    let receivedAt: String
    let friendId: Int
    let receiverId: Int
    let senderId: Int
    let senderNickname: String
}
