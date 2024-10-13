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

extension LoginRequestDTO {
    func toData() -> Data? {
        let encoder = JSONEncoder()
               do {
                   let data = try encoder.encode(self)
                   return data
               } catch {
                   print("Failed to encode user: \(error.localizedDescription)")
                   return nil
               }
    }
}
