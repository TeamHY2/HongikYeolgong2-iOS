//
//  User.swift
//  HongikYeolgong2-iOS
//
//  Created by 변정훈 on 7/12/24.
//

import Foundation

struct User: FirebaseIdentifiable, Decodable {
    var id: String
    var nickname: String
    let email: String
}
