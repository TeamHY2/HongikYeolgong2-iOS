//
//  RecordView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct RecordView: View {
    @Environment(\.injected.interactors.studyTimeInteractor) var studyTimeInteractor
    @State private var studyTime: Loadable<StudyTime> = .notRequest
    
    
    @State private var selectedDate: Date = Date()
    
    var body: some View {
        NetworkStateView(
            loadables: [AnyLoadable($studyTime)],
            retryAction: loadData
        ) {
            VStack(spacing: 13.adjustToScreenHeight) {
                // 데이터가 없을 경우 디폴트값으로 표현
                StudyRecordView(selectedDate: $selectedDate, studyTime: studyTime.value ?? StudyTime())
                Spacer()
                CaledarView()
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
            .padding(.top, 32.adjustToScreenHeight)
            .padding(.bottom, 36.adjustToScreenHeight)
            .onAppear(perform: loadData)
        }
        .modifier(IOSBackground())
    }
    
    // 데이터 불러오기
    func loadData() -> Void {
        studyTimeInteractor.getStudyTime(StudyTime: $studyTime)
    }
}
