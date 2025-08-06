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
    case getStudyStatus // FocusMode 데이터 불러오기
    case getLibraryHour
    
    case postStartStudy(StartStudyRequestDTO)
    case postEndStudy(EndStudyRequestDTO)
}

extension WeeklyEndpoint {
    var baseURL: URL? {
        URL(string: "\(SecretKeys.baseUrl)")
    }
    var path: String {
        switch self {
            case .getWeeklyStudy:
                "/study/record/week"
            case .getWiseSaying:
                "/wise-saying"
            case .getWeekField:
                "/week-field"
            case .getWeeklyRanking:
                "/study/ranking"
                
            case .getAllStudyRecords:
                "/study/record/count-all"
                
            case .getStudyTime:
                "/study/record/duration"
            case .getLibraryHour:
                "/library"
            case .getStudyStatus:
                "/study/session"
            case .postStartStudy:
                "/study/session/start"
            case .postEndStudy:
                "/study/session/end"
            default:
                "/study"
        }
    }
    
    var method: NetworkMethod {
        switch self {
            case .getWeeklyStudy, .getWiseSaying, .getWeekField, .getWeeklyRanking, .getAllStudyRecords, .getStudyTime, .getLibraryHour, .getStudyStatus:
                    .get
            case .uploadStudySession, .postStartStudy, .postEndStudy:
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
            case let .postStartStudy(startStudyRequestDTO):
                return startStudyRequestDTO.toData()
            case let .postEndStudy(endStudyRequestDTO):
                return endStudyRequestDTO.toData()
            default:
                return nil
        }
    }
}
