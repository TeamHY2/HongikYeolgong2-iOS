//
//  WeeklyStudyCell.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import SwiftUI

struct WeeklyStudyCell: View {
    let studyRoomUsage: StudyRoomUsage
    
    var body: some View {
        VStack(spacing: 0) {
            Text("월")
                .font(.pretendard(size: 12, weight: .regular), lineHeight: 18)
                .foregroundStyle(.gray400)
            
            Image(.star)
                .padding(.top, 8)
                .padding(.bottom, 2)
            
            Text(studyRoomUsage.monthOfDay)
                .font(.pretendard(size: 12, weight: .regular), lineHeight: 18)
                .foregroundStyle(.gray400)
        }
    }
}

