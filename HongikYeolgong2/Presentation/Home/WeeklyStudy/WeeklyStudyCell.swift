//
//  WeeklyStudyCell.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import SwiftUI

struct WeeklyStudyCell: View {
    let studyRecord: WeeklyStudyRecord
    
    var body: some View {
        VStack(spacing: 0) {
            Text(studyRecord.dayOfWeek)
                .font(.pretendard(size: 12, weight: .regular), lineHeight: 18)
                .foregroundStyle(textColor)
            
            Image(studyRecord.imageName)
                .padding(.top, 8)
                .padding(.bottom, 2)
            
            Text(studyRecord.monthOfDay)
                .font(.pretendard(size: 12, weight: .regular), lineHeight: 18)
                .foregroundStyle(textColor)
        }
    }
    
    private var textColor: Color {
        studyRecord.isUpcomming ? .white : .gray400
    }
}
