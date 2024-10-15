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
}
