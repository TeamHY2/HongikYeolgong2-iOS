//
//  URLRequest+.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/23/24.
//

import Foundation

// TODO: 추후에 Interceptor를 지원하는 라이브러리 사용의논
extension URLRequest {
    init(_ url: URL) {
        self.init(url: url)
        let accessToken = KeyChainManager.readItem(key: .accessToken) ?? ""          
        self.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }
}
