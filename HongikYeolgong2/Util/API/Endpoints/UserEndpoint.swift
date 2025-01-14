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
    
    /// 회원가입
    case signUp(signUpReqDto: SignUpRequestDTO)
    
    case profileEdit(signUpReqDto: SignUpRequestDTO)
    
    /// 유저정보
    case getUser
    
    /// 유저 프로필
    case getUserProfile
}

extension UserEndpoint {
    var baseURL: URL? {
        URL(string: "\(SecretKeys.baseUrl)/user")
    }
    var path: String {
        switch self {
        case .profileEdit:
            ""
        case .checkUserNickname:
            "/duplicate-nickname"
        case .signUp:
            "/join"
        case .getUser:
            "/me"
        case .getUserProfile:
            "/me"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .profileEdit:
                .put
        case  .signUp:
                .post
        case .getUser, .checkUserNickname, .getUserProfile:
                .get
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .checkUserNickname(nickname):
            return [URLQueryItem(name: "nickname", value: nickname)]
        case .signUp, .getUser, .getUserProfile:
            return nil
        default:
            return nil
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
        case let .profileEdit(signUpReqDto):
            return signUpReqDto.toData()
        case .checkUserNickname:
            return nil
        case let .signUp(signUpReqDto):
            return signUpReqDto.toData()
        case .getUser:
            return nil
        case .getUserProfile:
            return nil
        }
    }
}
