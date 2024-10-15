//
//  LoginRequestDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation

enum SocialLoginType: String, Encodable {
    case apple = "apple"
    case google = "google"
}

struct LoginRequestDTO: Encodable {
    let socialPlatform: String
    let idToken: String
}



