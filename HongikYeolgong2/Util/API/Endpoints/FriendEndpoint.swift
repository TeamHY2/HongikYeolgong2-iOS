//
//  FriendEndpoint.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/22/25.
//

import Foundation
enum FriendEndpoint {
    case searchFriend(nickname: String)
    case addFriend(receiverId: Int)
    case respondFriendRequest(senderId: Int, isAccepted: Bool)
    case getFriendsTimeList(dateType: RankingType)
    case getNotification
}

extension FriendEndpoint: EndpointProtocol {
    var baseURL: URL? {
        URL(string: "\(SecretKeys.baseUrl)v2")
    }
    
    var path: String {
        switch self {
            case .searchFriend:
                "/friends"
            case .addFriend:
                "/friends"
            case .respondFriendRequest:
                "/friends"
            case .getFriendsTimeList:
                "/friends/study"
            case .getNotification:
                "/notification"
        }
    }
    
    var method: NetworkMethod {
        switch self{
            case .searchFriend, .getFriendsTimeList, .getNotification:
                    .get
            case .addFriend:
                    .post
            case .respondFriendRequest:
                    .patch
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
            case let .searchFriend(nickname):
                return [URLQueryItem(name: "nickname", value: nickname)]
            case let .getFriendsTimeList(type):
                return [URLQueryItem(name: "dateType", value: type.typeName)]
            case .addFriend, .respondFriendRequest, .getNotification:
                return nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            ["Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
            case .searchFriend, .getFriendsTimeList, .getNotification:
                return nil
            case let .addFriend(receiverId):
                return AddFriendRequestDTO(receiverId: receiverId).toData()
            case let .respondFriendRequest(senderId, isAccepted):
                return FriendRespondDTO(senderId: senderId, isAccepted: isAccepted).toData()
        }
    }
    
    
}
