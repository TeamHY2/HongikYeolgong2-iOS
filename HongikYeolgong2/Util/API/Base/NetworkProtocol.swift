//
//  NetworkProtocol.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/13/24.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws ->  (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}

protocol NetworkProtocol {
    var session: URLSessionProtocol { get }
    func request<T: Decodable>(endpoint: EndpointProtocol) async throws -> T
}

enum NetworkMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol EndpointProtocol {
    var baseURL: URL? { get }
    var path: String { get }
    var method: NetworkMethod { get }
    var parameters: [URLQueryItem]? { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}


