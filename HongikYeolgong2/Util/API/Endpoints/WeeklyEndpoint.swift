//
//  WeeklyEndpoint.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation

/// 소셜로그인 관련 엔드포인트 정의
enum WeeklyEndpoint: EndpointProtocol {
    
    /// 애플 소셜 로그인
    case getWeeklyStudy
}

extension WeeklyEndpoint {
    var baseURL: URL? {
        URL(string: SecretKeys.baseUrl)
    }
    var path: String {
        switch self {
        case .getWeeklyStudy:
            "/week-field"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .getWeeklyStudy:
                .post
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case .getWeeklyStudy:
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
        case .getWeeklyStudy:
            return nil
        }
    }
}
