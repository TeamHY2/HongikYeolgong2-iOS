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
    
    /// 문자열 형식의 날짜를 Date 객체로 변환합니다.
    /// - Returns: Date
    func toDate() -> Date? {
        let dateFormatter = Self.dateFormatter
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        return date
    }
    
    /// 날짜 형식을 변환합니다. "2024-10-24" -> "10/24"
    /// - Returns: 월/일
    func toMonthOfDay() -> String {
        guard let date = self.toDate() else {
            return "날짜오류"
        }
        
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return "\(month)/\(day)"
    }
    
    /// 받은 날짜의 요일을 반환합니다
    /// - Returns:요일
    func toDayOfWeek() -> String {
        guard let date = self.toDate() else {
            return "날짜오류"
        }
        
        let calendar = Calendar.current
        let weekDay = calendar.component(.weekday, from: date)
        
        return WeekDay(rawValue:  weekDay - 1)?.koreanString ?? ""
    }
}
