//
//  FriendStudyTimeMapper.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/25/25.
//

import Foundation

extension FriendsTimeListRespondDTO {
    func toEntity() -> FriendStudyTime {
        .init(userId: userId,
              friendId: friendId,
              friendNickname: friendNickname,
              studyTime: studyTime)
    }
}
