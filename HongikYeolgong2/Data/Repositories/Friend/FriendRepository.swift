//
//  FriendRepository.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/23/25.
//

import Combine

protocol FriendRepository {
    func getSerchUser(nickname: String) -> AnyPublisher<[SearchUser], NetworkError>
    func postAddFriend(userId: Int) -> AnyPublisher<Bool, NetworkError>
    func getFriendsTimeList(dateType: RankingType) -> AnyPublisher<[FriendStudyTime], NetworkError>
    func respondFriendRequest(info: Notification, isAccept: Bool) -> AnyPublisher<Bool, NetworkError>
    func requestCancelFriend(userId: Int) -> AnyPublisher<Bool, NetworkError>
    func getNotification() -> AnyPublisher<[Notification], NetworkError>
}
