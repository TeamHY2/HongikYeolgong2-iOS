//
//  UserProfile.swift
//  HongikYeolgong2
//
//  Created by 변정훈 on 11/9/24.
//

import Foundation

struct UserProfile: Equatable, Decodable {
    var id: Int
    var username: String
    var nickname: String
    var department: String
    
    init(id: Int, username: String, nickname: String, department: String) {
        self.id = id
        self.username = username
        self.nickname = nickname
        self.department = department
    }
    
    init() {
        self.id = 1
        self.username = "email@email.com"
        self.nickname = "닉네임"
        self.department = "디자인학부"
    }
}
