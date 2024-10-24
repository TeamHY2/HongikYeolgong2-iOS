//
//  WeeklyStudy.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/5/24.
//

import SwiftUI

struct WeeklyStudyView: View {
    let weeklyStudy: [StudyRoomUsage]
    
    var body: some View {
        HStack {
            ForEach(Array(weeklyStudy.enumerated()), id: \.self.offset) { (offset, studyRoomUsage) in
                WeeklyStudyCell(studyRoomUsage: studyRoomUsage)
                if offset != 7 {
                    Spacer()
                }
            }
        }
    }
}
