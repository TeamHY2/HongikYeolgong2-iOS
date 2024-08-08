//
//  CalendarCell.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/12/24.
//

import SwiftUI

enum CellStyle: CaseIterable {
    case dayCount00
    case dayCount01
    case dayCount02
    case dayCount03
    
}

struct CalendarCell: View {
    
    let dayInfo: Day
    
    private var cellStyle: CellStyle {
        if dayInfo.todayUsageCount >= 3 {
            return .dayCount03
        } else if dayInfo.todayUsageCount >= 2 {
            return .dayCount02
        } else if dayInfo.todayUsageCount >= 1 {
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
                CustomText(font: .suite, title: dayInfo.dayOfNumber, textColor: .customGray300, textWeight: .medium, textSize: 14)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Color(.customGray800))
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        case .dayCount01:
            VStack {
                CustomText(font: .suite, title: dayInfo.dayOfNumber, textColor: .customGray100, textWeight: .medium, textSize: 14)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Image(.dayCount01))
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        case .dayCount02:
            VStack {
                CustomText(font: .suite, title: dayInfo.dayOfNumber, textColor: .white, textWeight: .medium, textSize: 14)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Image(.dayCount02))
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        case .dayCount03:
            VStack {
                CustomText(font: .suite, title: dayInfo.dayOfNumber, textColor: .customGray600, textWeight: .medium, textSize: 14)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIScreen.UIHeight(33))
            .background(Image(.dayCount03))
            .cornerRadius(8)
            .opacity(isVisible ? 0 : 1)
        }
    }
}

#Preview {
    CalendarCell(dayInfo: Day(dayOfNumber: "1"))
}
