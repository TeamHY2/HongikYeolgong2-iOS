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
}

extension FriendEndpoint: EndpointProtocol {
    var baseURL: URL? {
        URL(string: "\(SecretKeys.baseUrl)")
    }
    
    var path: String {
        switch self {
            case .searchFriend:
                "/friends"
            case .addFriend:
                "/friends"
            case .respondFriendRequest:
                "/friends"
        }
    }
    
    var method: NetworkMethod {
        switch self{
            case .searchFriend:
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
            case .addFriend, .respondFriendRequest:
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
            case .searchFriend:
                return nil
            case let .addFriend(receiverId):
                return receiverId.toData()
            case let .respondFriendRequest(senderId, isAccepted):
                return FriendRespondDTO(senderId: senderId, isAccepted: isAccepted).toData()
        }
    }
    
    
}
