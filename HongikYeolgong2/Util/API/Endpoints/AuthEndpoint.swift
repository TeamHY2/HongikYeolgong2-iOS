//
//  authEndpoint.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/13/24.
//

import Foundation

/// 소셜로그인 관련 엔드포인트 정의
enum AuthEndpoint: EndpointProtocol {
    
    /// 애플 소셜 로그인
    case login(loginReqDto: LoginRequestDTO)
}

extension AuthEndpoint {
    var baseURL: URL? {
        URL(string: "\(SecretKeys.baseUrl)/auth")
    }
    var path: String {
        switch self {
        case .login:
            "/login"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .login:
                .post
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .login:
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
        case let .login(loginReqDto):
            return loginReqDto.toData()
        }
    }
}
