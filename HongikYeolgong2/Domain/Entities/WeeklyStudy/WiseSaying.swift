//
//  WiseSaying.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/28/24.
//

import Foundation

struct WiseSaying: Decodable {
    var quote: String
    let author: String
    
    init(quote: String, author: String) {
        self.quote = quote
        self.author = author
    }
    
    init() {
        self.quote = "행동보다 빠르게 불안감을 \n 없앨 수 있는 것은 없습니다."
        self.author = "윌터 앤더슨"
    }
}
