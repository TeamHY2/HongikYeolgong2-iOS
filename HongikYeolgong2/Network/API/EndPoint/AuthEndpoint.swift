//
//  AuthEndpoint.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/13/25.
//

import Foundation
import Alamofire

enum AuthEndpoint {
    case loginTest
}

extension AuthEndpoint: EndPoint {
    var baseURL: String {
        return SecretKey.baseUrl
    }
    
    var path: String {
        return "/login-apple"
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var task: APITask {
        let testDto = LoginRequestDTO(email: "", idToken: "")
        return .requestJSONEncodable(parameters: testDto)
    }
}
