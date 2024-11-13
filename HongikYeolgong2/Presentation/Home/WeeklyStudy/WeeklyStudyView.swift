//
//  WeeklyStudy.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/5/24.
//

import SwiftUI

struct WeeklyStudyView: View {
    let studyRecords: [WeeklyStudyRecord]
    
    var body: some View {
        HStack {
            ForEach(Array(studyRecords.enumerated()), id: \.self.offset) { (offset, stduyRecord) in
                if offset != 0 && offset != 7 {
                    Spacer()
                }
                WeeklyStudyCell(
                    dayOfWeek: .init(rawValue: offset) ?? .monday,
                    studyRecord: stduyRecord
                )
            }
        }
        .padding(.top, 32.adjustToScreenHeight)
    }
}
