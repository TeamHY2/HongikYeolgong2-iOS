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
    case getWiseSaying
    case getWeekField(date: String)
    case getWeeklyRanking(yearWeek: Int)

    case getAllStudyRecords

    case getStudyTime(date: Date)

}

extension WeeklyEndpoint {
    var baseURL: URL? {
        URL(string: "\(SecretKeys.baseUrl)")
    }
    var path: String {
        switch self {
        case .getWeeklyStudy:
            "/study/week"
        case .getWiseSaying:
            "/wise-saying"
        case .getWeekField:
            "/week-field"
        case .getWeeklyRanking:
            "/study/ranking"

        case .getAllStudyRecords:
            "/study/count-all"

        case .getStudyTime:
            "/study/duration"

        default:
            "/study"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .getWeeklyStudy, .getWiseSaying, .getWeekField, .getWeeklyRanking, .getAllStudyRecords, .getStudyTime:
                .get
        case .uploadStudySession:
                .post
        }
    }
    
    var parameters: [URLQueryItem]? {
        switch self {
        case let .getWeekField(date):
            return [URLQueryItem(name: "date", value: date)]
        case let .getWeeklyRanking(yearWeek):
            return [URLQueryItem(name: "yearWeek", value: "\(yearWeek)")]
            case let .getStudyTime(date):
                let dateString = date.toDateString()
                return [URLQueryItem(name: "date", value: "\(dateString)")]
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
        case let .uploadStudySession(studySessionReqDto):
            return studySessionReqDto.toData()
        default:
            return nil
        }
    }
}
