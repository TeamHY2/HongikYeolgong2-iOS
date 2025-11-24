//
//  FriendSearchUser.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/20/25.
//

import Foundation

enum FriendStatus: String, Hashable {
    case pending = "PENDING"
    case accepted = "ACCEPTED"
    case rejected = "REJECTED"
    case none = "NONE"
    case loading = "LOADING"
}

struct SearchUser: Hashable {
    let userId: Int
    let nickname: String
    var friendStatus: FriendStatus
}
