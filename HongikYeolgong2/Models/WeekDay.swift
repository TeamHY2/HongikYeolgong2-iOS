//
//  WeekDay.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/25/24.
//

import Foundation

enum WeekDay: Int {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var koreanString: String {
        switch self {
        case .monday: return "월"
        case .tuesday: return "화"
        case .wednesday: return "수"
        case .thursday: return "목"
        case .friday: return "금"
        case .saturday: return "토"
        case .sunday: return "일"
        }
    }
    
    static func from(koreanString: String) -> WeekDay? {
        switch koreanString {
        case "월": return .monday
        case "화": return .tuesday
        case "수": return .wednesday
        case "목": return .thursday
        case "금": return .friday
        case "토": return .saturday
        case "일": return .sunday
        default: return nil
        }
    }
}
