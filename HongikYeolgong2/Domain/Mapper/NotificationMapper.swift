//
//  NotificationMapper.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/29/25.
//

import Foundation

extension NotificationRespondDTO {
    func toEntity() -> Notification {
        .init(notificationId: notificationId,
              type: NotificationType(rawValue: type) ?? .exception,
              content: content,
              receivedAt: receivedAt,
              friendId: friendId,
              receiverId: receiverId,
              senderId: senderId,
              senderNickname: senderNickname)
    }
}
