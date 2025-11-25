//
//  FriendStudyTime.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/25/25.
//

import Foundation

struct FriendStudyTime: Hashable {
    let userId: Int
    let friendId: Int
    let friendNickname: String
    let studyTime: Date
    
    // "hhH mmM" 형태 반환
    var studyTimeString: String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: studyTime)
        let minute = calendar.component(.minute, from: studyTime)

        return hour > 0 ? "\(hour)H \(minute)M" : "\(minute)M"
    }
    
    init(userId: Int, friendId: Int, friendNickname: String, studyTime: String) {
        // Date형태 변환
        let formatter = DateFormatter()
        formatter.dateFormat = "H:m:s"
        let studyTime = formatter.date(from: studyTime)!
        
        self.userId = userId
        self.friendId = friendId
        self.friendNickname = friendNickname
        self.studyTime = studyTime
    }
}
