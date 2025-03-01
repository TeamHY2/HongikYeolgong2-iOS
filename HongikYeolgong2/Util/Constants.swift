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
    static let appleIDApiUrl = Bundle.main.infoDictionary?["AppleIdURL"] as? String ?? ""
    static let bundleName = Bundle.main.bundleIdentifier ?? ""
    static let teamID = Bundle.main.infoDictionary?["TeamID"] as? String ?? ""
    static let serviceID = Bundle.main.infoDictionary?["ServiceID"] as? String ?? ""
    static let ampliKey = Bundle.main.infoDictionary?["AmplitudeKey"] as? String ?? ""
    static let appleID = Bundle.main.infoDictionary?["AppleID"] as? String ?? ""
    static let metaAppID = Bundle.main.infoDictionary?["MetaAppID"] as? String ?? ""
}


