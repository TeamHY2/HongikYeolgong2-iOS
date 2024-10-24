//
//  String+.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/25/24.
//

import Foundation

extension String {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "KST")
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
    
    func toDate() -> Date? {
        let dateFormatter = Self.dateFormatter
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
    
    func toMonthOfDay() -> String {
        guard let date = self.toDate() else {
            return "날짜오류"
        }
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return "\(month)/\(day)"
    }
    
    func toDayOfWeek() -> String {
        guard let date = self.toDate() else {
            return "날짜오류"
        }
        
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: date)
        
        return WeekDay(rawValue:  weekDay - 1)?.koreanString ?? ""
    }
}
