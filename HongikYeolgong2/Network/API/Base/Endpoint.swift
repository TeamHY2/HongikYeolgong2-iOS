//
//  Endpoint.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/13/25.
//

import Foundation
import Alamofire

protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
       var method: HTTPMethod { get }
       var headers: HTTPHeaders? { get }
       var task: APITask { get }
}

extension EndPoint {
    var headers: HTTPHeaders? { return ["Content-Type": "application/json"] }
}
