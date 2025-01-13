//
//  Secret.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/14/25.
//

import Foundation

struct SecretKey {
    static var baseUrl = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
}
