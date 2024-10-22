//
//  NetworkError.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case decodingError(String)
    case serverError(statusCode: Int)
    
    var message: String {
        switch self {
        case .invalidUrl:
            "올바르지 않은 URL 입니다."
        case .invalidResponse:
            "올바르지 않은 응답형식 입니다."
        case .decodingError:
            "디코딩 에러"
        case let .serverError(statusCode):
            "서버에러: \(statusCode)"
        }
    }
}
