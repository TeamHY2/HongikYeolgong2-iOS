//
//  WeeklyEndpoint.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation

/// 소셜로그인 관련 엔드포인트 정의
enum WeeklyEndpoint: EndpointProtocol {
    
    /// 이번주 열람실 이용횟수
    case getWeeklyStudy
    case uploadStudySession(StudySessionRequestDTO)
}

extension WeeklyEndpoint {
    var baseURL: URL? {
        URL(string: "\(SecretKeys.baseUrl)")
    }
    var path: String {
        switch self {
        case .getWeeklyStudy:
            "/study/week"
        default:
            "/study"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .getWeeklyStudy:
                .get
        case .uploadStudySession:
                .post
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        default:
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
        case let .uploadStudySession(studySessionReqDto):
            return studySessionReqDto.toData()
        }
    }
}
