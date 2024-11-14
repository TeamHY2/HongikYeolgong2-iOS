//
//  Page.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/14/24.
//

import Foundation

enum Page: Hashable {
    case webView(title: String, url: String)
    case signUp
}
