//
//  StudyNotificationType.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/8/24.
//

import Foundation

enum LocalNotification {
    case extensionAvailable
    case urgent
    
    var timeOffset: TimeInterval {
        switch self {
        case .extensionAvailable:
            return .init(minutes: 30)
        case .urgent:
            return  .init(minutes: 10)
        }
    }
    
    var message: String {
        switch self {
        case .extensionAvailable:
            return "열람실 시간 종료 30분 전이에요. 지금부터 열람실 연장이 가능해요!"
        case .urgent:
            return "열람실 시간 종료 10분 전이에요. 열람실 연장이 필요하다면 서둘러주세요!"
        }
    }
}
