//
//  RecordView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct RecordView: View {
    @Environment(\.injected.interactors.studyTimeInteractor) var studyTimeInteractor    
    @State var studyTime = StudyTime()
    
    var body: some View {
        VStack(spacing: 13.adjustToScreenHeight) {
            
            CaledarView()
            
            Spacer()
            // 기록 정보 출력부분
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
        .modifier(IOSBackground())
        .padding(.horizontal, 32.adjustToScreenWidth)
        .padding(.top, 32.adjustToScreenHeight)
        .padding(.bottom, 36.adjustToScreenHeight)
        .onAppear {
            // 이용 시간 가져오기
            studyTimeInteractor.getStudyTime(StudyTime: $studyTime)
        }
    }
}

//#Preview {
//    RecordView()
//}
