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
    
    func postAddFriend(userId: Int) -> AnyPublisher<Bool, NetworkError> {
        return Future<Bool, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<AddFriendRespondDTO> = try await NetworkService.shared.request(endpoint: FriendEndpoint.addFriend(receiverId: userId))
                    let result = response.message == "OK"
                    
                    promise(.success(result))
                } catch let error as NetworkError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getFriendsTimeList(dateType: RankingType) -> AnyPublisher<[FriendStudyTime], NetworkError> {
        return Future<[FriendStudyTime], NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<[FriendsTimeListRespondDTO]> = try await NetworkService.shared.request(endpoint: FriendEndpoint.getFriendsTimeList(dateType: dateType))
                    promise(
                        .success(
                            response.data
                                .map { $0.toEntity()}
                                .sorted{ $0.totalSeconds > $1.totalSeconds }
                        ))
                } catch let error as NetworkError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func respondFriendRequest(senderId: Int, isAccept: Bool) -> AnyPublisher<Bool, NetworkError> {
            return Future<Bool, NetworkError> { promise in
                Task {
                    do {
                        let response: BaseResponse<patchFriendRespondDTO> = try await NetworkService.shared.request(endpoint: FriendEndpoint.respondFriendRequest(senderId: senderId, isAccepted: isAccept))
                        // 정상처리 된 경우에만 -> 이후 추가 로직 필요할 경우 수정
                        let result = response.message == "OK"
                        
                        promise(.success(result))
                    } catch let error as NetworkError {
                        promise(.failure(error))
                    }
                }
            }.eraseToAnyPublisher()
    }
}
