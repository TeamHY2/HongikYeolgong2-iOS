//
//  UserEndpoint.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/19/24.
//

import Foundation

/// 유저  관련 엔드포인트 정의
enum UserEndpoint: EndpointProtocol {
    
    /// 애플 소셜 로그인
    case checkUserNickname(nickname: String)
}

extension UserEndpoint {
    var baseURL: URL? {
        URL(string: "\(SecretKeys.baseUrl)/user")
    }
    var path: String {
        switch self {
        case .checkUserNickname:
            "/duplicate-nickname"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .checkUserNickname:
                .post
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .checkUserNickname:
            nil
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            ["Content-Type": "application/json"]
        }
    }
    
    var body: Data? {
        switch self {
        case let .checkUserNickname(nickname):
            let parameter: [String: Any] = ["nickname": nickname]            
            return parameter.toData()
        }
    }
}
