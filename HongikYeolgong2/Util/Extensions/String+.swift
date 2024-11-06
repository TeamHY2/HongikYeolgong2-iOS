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
}
