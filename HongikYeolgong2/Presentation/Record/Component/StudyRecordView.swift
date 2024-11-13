//
//  StudyRecordView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/13/24.
//

import SwiftUI

struct StudyRecordView: View {
    var studyTime: StudyTime
    
    var body: some View {
        HStack(spacing: 13.adjustToScreenWidth) {
            RecordCell(title: "연간",
                       hours: studyTime.yearHours,
                       minutes: studyTime.yearMinutes)
            RecordCell(title: "이번학기",
                       hours: studyTime.semesterHours,
                       minutes: studyTime.semesterMinutes)
        }
        HStack(spacing: 13.adjustToScreenWidth) {
            RecordCell(title: "월간",
                       hours: studyTime.monthHours,
                       minutes: studyTime.monthMinutes)
            RecordCell(title: "투데이",
                       hours: studyTime.dayHours,
                       minutes: studyTime.dayMinutes)
        }
    }
}
