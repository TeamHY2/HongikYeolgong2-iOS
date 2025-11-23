//
//  FriendRepositoryImpl.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/23/25.
//

import Combine

final class FriendRepositoryImpl: FriendRepository {
    func getSerchUser(nickname: String) -> AnyPublisher<[SearchUser], NetworkError> {
        return Future<[SearchUser], NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<[SearchFriendRespondDTO]> = try await NetworkService.shared.request(endpoint: FriendEndpoint.searchFriend(nickname: nickname))
                    promise(.success(response.data.map { $0.toEntity()}))
                } catch let error as NetworkError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
