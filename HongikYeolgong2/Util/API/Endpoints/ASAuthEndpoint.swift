//
//  ASAuthEndpoint.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/11/24.
//

import Foundation

enum ASAuthEndpoint: EndpointProtocol {
    case requestToken
    
    var baseURL: URL? {
        switch self {
        case .requestToken:
            URL(string: "\(SecretKeys.appleAuthUrl)")
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
        case .requestToken:
            nil
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            ["Content-Type": "application/json", "form-data": "application/x-www-form-urlencoded"]
        }
    }
    
    var body: Data? {
        switch self {
        case .requestToken:
            nil
        }
    }
}
