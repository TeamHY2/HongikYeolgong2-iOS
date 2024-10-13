//
//  authEndpoint.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/13/24.
//

import Foundation

enum AuthEndpoint: EndpointProtocol {
    case login
    
    var baseURL: URL? {
        URL(string: baseUrl)
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
        case .login:
            nil
        }
    }
    
    var body: Data? {
        switch self {
        case .login:
            nil
        }
    }
}
