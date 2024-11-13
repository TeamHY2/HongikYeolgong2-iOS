//
//  WeeklyStudyCell.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import SwiftUI

struct WeeklyStudyCell: View {
    let dayOfWeek: WeekDay
    let studyRecord: WeeklyStudyRecord
    
    var body: some View {
        VStack(spacing: 0) {
            Text(dayOfWeek.koreanString)
                .font(.pretendard(size: 12, weight: .regular), lineHeight: 18.adjustToScreenHeight)
                .foregroundStyle(textColor)
            
            VStack {
                Image(studyRecord.imageName)                    
            }
            .frame(height: 28.adjustToScreenHeight)
            .padding(.top, 8.adjustToScreenHeight)
            .padding(.bottom, 2.adjustToScreenHeight)
            
            Text(studyRecord.monthOfDay)
                .font(.pretendard(size: 12, weight: .regular), lineHeight: 18.adjustToScreenHeight)
                .foregroundStyle(textColor)
        }
    }
    
    private var textColor: Color {
        studyRecord.isUpcomming ? .white : .gray400
    }
}
