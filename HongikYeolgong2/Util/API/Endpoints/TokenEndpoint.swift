////
////  TokenEndpoint.swift
////  HongikYeolgong2
////
////  Created by 권석기 on 11/6/24.
////
//
//import Foundation
//
//enum TokenEndpoint: EndpointProtocol {
//    case validToken
//    
//    var baseURL: URL? {
//        switch self {
//        case .validToken:
//            URL(string: "\(SecretKeys.baseUrl)")
//        }
//    }
//    
//    var path: String {
//        switch self {
//        case .validToken:
//            "/token"
//        }
//    }
//    
//    var method: NetworkMethod {
//        switch self {
//        case .validToken:
//                .get
//        }
//    }
//    
//    var parameters: [URLQueryItem]? {
//        switch self {
//        case .validToken:
//            nil
//        }
//    }
//    
//    var headers: [String : String]? {
//        switch self {
//        default:
//            ["Content-Type": "application/json"]
//        }
//    }
//    
//    var body: Data? {
//        switch self {
//        case .validToken:
//            nil
//        }
//    }
//}
