//
//  URLRequest+.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/23/24.
//

import Foundation

// TODO: 추후에 Interceptor를 지원하는 라이브러리 사용의논
extension URLRequest {
    init(_ url: URL, testToken: String? = nil) {
        self.init(url: url)
        let accessToken = testToken ?? KeyChainManager.readItem(key: .accessToken) ?? ""
        print("accessToken: ",accessToken)
        self.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }
}
