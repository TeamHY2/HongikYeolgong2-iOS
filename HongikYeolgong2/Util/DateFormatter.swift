//
//  DateFormatter.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation

extension String {
    
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"       
        dateFormatter.timeZone = TimeZone(identifier: "KST")
        dateFormatter.locale = Locale(identifier: "ko_KR")
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
}
