//
//  CalendarCell.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/4/25.
//

import SwiftUI

enum MoveType {
    case current
    case next
    case prev
}

enum WeekDayEng: String, CaseIterable {
    case sun = "Sun"
    case Mon = "Mon"
    case Tue = "Tue"
    case Wed = "Wed"
    case Thu = "Thu"
    case Fri = "Fri"
    case Sat = "Sat"
}

struct AllStudyRecord: Equatable {
    let day: String
    let month: String
    let year: String
    let date: Date
    let studyCount: Int
}

enum CellStyle: CaseIterable {
    case dayCount00
    case dayCount01
    case dayCount02
    case dayCount03
}

struct Day: Identifiable {
    var id = UUID().uuidString
    let dayOfNumber: String
    var usageRecord: [AllStudyRecord] = []
    
    var todayUsageCount: [Int] {
        return usageRecord.map {$0.studyCount}
    }
}

struct CalendarCell: View {
    let dayInfo: Day
    
    private var cellStyle: CellStyle {
        let maxUsageCount = dayInfo.todayUsageCount.max() ?? 0
        
        if maxUsageCount >= 3 {
            return .dayCount03
        } else if maxUsageCount >= 2 {
            return .dayCount02
        } else if maxUsageCount >= 1 {
            return .dayCount01
        } else {
            return .dayCount00
        }
    }
    
    private var isVisible: Bool {
        dayInfo.dayOfNumber.isEmpty
    }
    
    var body: some View {
        switch cellStyle {
        case .dayCount00:
            VStack {
                Text(dayInfo.dayOfNumber)
                    .font(.suite(size: 14, weight: .medium))
                    .foregroundStyle(Color.gray300)
            }
            .frame(width: 40.adjustToScreenWidth,height: 33.adjustToScreenHeight)
            .background(Image(.dayCount00)
                .resizable()
                .frame(width: 40.adjustToScreenWidth,height: 33.adjustToScreenHeight))
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        case .dayCount01:
            VStack {
                Text(dayInfo.dayOfNumber)
                    .font(.suite(size: 14, weight: .medium))
                    .foregroundStyle(Color.gray100)
            }
            .frame(width: 40.adjustToScreenWidth,height: 33.adjustToScreenHeight)
            .background(Image(.dayCount01)
                .resizable()
                .frame(width: 40.adjustToScreenWidth,height: 33.adjustToScreenHeight))
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        case .dayCount02:
            VStack {
                Text(dayInfo.dayOfNumber)
                    .font(.suite(size: 14, weight: .medium))
                    .foregroundStyle(Color.white)
            }
            .frame(width: 40.adjustToScreenWidth,height: 33.adjustToScreenHeight)
            .background(Image(.dayCount02)
                .resizable()
                .frame(width: 40.adjustToScreenWidth,height: 33.adjustToScreenHeight))
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        case .dayCount03:
            VStack {
                Text(dayInfo.dayOfNumber)
                    .font(.suite(size: 14, weight: .medium))
                    .foregroundStyle(Color.gray600)
            }
            .frame(width: 40.adjustToScreenWidth,height: 33.adjustToScreenHeight)
            .background(Image(.dayCount03)
                .resizable()
                .frame(width: 40.adjustToScreenWidth,height: 33.adjustToScreenHeight))
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        }
    }
}
