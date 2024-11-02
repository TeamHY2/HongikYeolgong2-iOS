//
//  Date+.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/27/24.
//

import Foundation

extension Date {
    func getHourMinutes() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let minutes = calendar.component(.minute, from: self)
        let hour12 = hour % 12 == 0 ? 12 : hour % 12
        
        return String(format: "%02d", hour12) + ":" + String(format: "%02d", minutes)
    }
    
    func getDaypart() -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: self)
        let daypart = hour < 12 ? "AM" : "PM"
        return daypart
    }
    
    func dateToISO8601() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let ISO8601String = formatter.string(from: self)
        
        return ISO8601String
    }
    
    func toDateString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "KST")
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: self)
        return dateString
    }
}
