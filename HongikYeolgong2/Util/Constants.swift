//
//  Constants.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/13/24.
//

import Foundation

struct SecretKeys {
    static let baseUrl = Bundle.main.infoDictionary?["BaseURL"] as? String ?? ""    
    static let roomStatusUrl = Bundle.main.infoDictionary?["RoomStatusURL"] as? String ?? ""
    static let noticeUrl = Bundle.main.infoDictionary?["NoticeURL"] as? String ?? ""
    static let qnaUrl = Bundle.main.infoDictionary?["QnaURL"] as? String ?? ""
}


