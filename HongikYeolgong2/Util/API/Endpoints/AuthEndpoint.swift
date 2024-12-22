////
////  authEndpoint.swift
////  HongikYeolgong2
////
////  Created by 권석기 on 10/13/24.
////
//
//import Foundation
//
///// 소셜로그인 관련 엔드포인트 정의
//enum AuthEndpoint: EndpointProtocol {
//    
//    /// 애플 소셜 로그인
//    case login(loginReqDto: LoginRequestDTO)
//    
//    /// 회원탈퇴
//    case withdraw
//}
//
//extension AuthEndpoint {
//    var baseURL: URL? {
//        URL(string: "\(SecretKeys.baseUrl)/auth")
//    }
//    var path: String {
//        switch self {
//        case .login:
//            "/login-apple"
//        case .withdraw:
//            ""
//        }
//    }
//    
//    var method: NetworkMethod {
//        switch self {
//        case .login:
//                .post
//        case .withdraw:
//                .delete
//        }
//    }
//    
//    var parameters: [URLQueryItem]? {
//        switch self {
//        case .login:
//            nil
//        default:
//            nil
//        }
//    }
//    
//    var headers: [String: String]? {
//        switch self {
//        default:
//            ["Content-Type": "application/json"]
//        }
//    }
//    
//    var body: Data? {
//        switch self {
//        case let .login(loginReqDto):
//            return loginReqDto.toData()
//        default:
//            return nil
//        }
//    }
//}
