//
//  ASAuthEndpoint.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/11/24.
//

import Foundation

enum ASAuthEndpoint: EndpointProtocol {
    case requestToken(ASTokenRequestDTO)
    
    var baseURL: URL? {
        switch self {
        case .requestToken:
            URL(string: "\(SecretKeys.appleIDApiUrl)")
        }
    }
    
    var path: String {
        switch self {
        case .requestToken:
            "/token"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .requestToken:
                .post
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .requestToken(asTokenRequestDto):
            [URLQueryItem(name: "client_id", value: asTokenRequestDto.client_id),
             URLQueryItem(name: "client_secret", value: asTokenRequestDto.client_secret),
             URLQueryItem(name: "code", value: asTokenRequestDto.code),
             URLQueryItem(name: "grant_type", value: asTokenRequestDto.grant_type)]
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
        case .requestToken:
            return nil
        }
    }
}
