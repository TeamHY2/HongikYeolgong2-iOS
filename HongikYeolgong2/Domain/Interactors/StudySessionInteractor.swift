//
//  WeeklyStudyInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import SwiftUI

protocol StudySessionInteractor {
    func getWeekyStudy(studyRecords: Binding<[WeeklyStudyRecord]>)
    func startStudy()
    func endStudy()
    func setStartTime(_ startTime: Date)
}

final class StudySessionInteractorImpl: StudySessionInteractor {
    private let appState: Store<AppState>
    private let cancleBag = CancelBag()
    private let studySessionRepository: StudySessionRepository
    
    init(appState: Store<AppState>,
         studySessionRepository: StudySessionRepository) {
        self.appState = appState
        self.studySessionRepository = studySessionRepository
    }
    
    /// 한 주에 대한 공부 횟수를 가져옵니다.
    /// - Parameter studyRecords: 공부 기록(월 - 일)
    func getWeekyStudy(studyRecords: Binding<[WeeklyStudyRecord]>) {
        studySessionRepository
            .getWeeklyStudyRecords()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) {
                studyRecords.wrappedValue = $0.map { $0.toEntity() }
            }
            .store(in: cancleBag)
    }
    
    func startStudy() {
        appState[\.studySession.isStudying] = true
    }
    
    func endStudy() {
        appState[\.studySession.isStudying] = false
    }
    
    func setStartTime(_ startTime: Date) {
        appState[\.studySession.startTime] = startTime
    }
}
