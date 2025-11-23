//
//  FriendRepository.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/23/25.
//

import Combine

protocol FriendRepository {
    func getSerchUser(nickname: String) -> AnyPublisher<[SearchUser], NetworkError>
}
