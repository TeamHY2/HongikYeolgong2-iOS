//
//  SearchUserMapper.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/23/25.
//

import Foundation

extension SearchFriendRespondDTO {
    func toEntity() -> SearchUser {
        SearchUser(userId: userId,
                         nickname: nickname,
                         friendStatus: friendStatus)
    }
}
