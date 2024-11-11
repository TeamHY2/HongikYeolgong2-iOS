//
//  ASAuthEndpoint.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/11/24.
//

import Foundation

enum ASAuthEndpoint: EndpointProtocol {
    case requestToken(ASTokenRequestDTO)
    case requestRevoke(ASRevokeTokenRequestDTO)
    
    var baseURL: URL? {
        switch self {
        default:
            URL(string: "\(SecretKeys.appleIDApiUrl)")
        }
    }
    
    var path: String {
        switch self {
        case .requestToken:
            "/token"
        case .requestRevoke:
            "/revoke"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .requestToken, .requestRevoke:
                .post
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .requestToken(asTokenRequestDto):
            return [URLQueryItem(name: "client_id", value: asTokenRequestDto.client_id),
                    URLQueryItem(name: "client_secret", value: asTokenRequestDto.client_secret),
                    URLQueryItem(name: "code", value: asTokenRequestDto.code),
                    URLQueryItem(name: "grant_type", value: asTokenRequestDto.grant_type)]
        case let .requestRevoke(asRevokeTokenRequestDto):
            return [URLQueryItem(name: "client_id", value: asRevokeTokenRequestDto.client_id),
                    URLQueryItem(name: "client_secret", value: asRevokeTokenRequestDto.client_secret),
                    URLQueryItem(name: "token", value: asRevokeTokenRequestDto.token)]
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            ["Content-Type": "application/x-www-form-urlencoded"]
        }
    }
    
    var body: Data? {
        switch self {
        case .requestToken, .requestRevoke:
            return nil
        }
    }
}
