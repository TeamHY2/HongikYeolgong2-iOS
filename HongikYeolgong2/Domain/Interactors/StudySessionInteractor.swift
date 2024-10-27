//
//  WeeklyStudyInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import SwiftUI
import Combine

protocol StudySessionInteractor {
    func getWeekyStudy(studyRecords: Binding<[WeeklyStudyRecord]>)
    func startStudy()
    func endStudy()
    func addTime()
    func setStartTime(_ startTime: Date)
}

final class StudySessionInteractorImpl: StudySessionInteractor {
    private let appState: Store<AppState>
    private let cancleBag = CancelBag()
    private let studySessionRepository: StudySessionRepository
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    private var subscription: AnyCancellable?
    
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
                studyRecords.wrappedValue = $0
            }
            .store(in: cancleBag)
    }
    
    func startStudy() {
        let startTime = appState.value.studySession.startTime
        let addedTime: TimeInterval = .init(minutes: 1)
        let endTime = startTime + addedTime
        let remainingTime = endTime.timeIntervalSince(startTime)
          
        appState.bulkUpdate { appState in
            appState.studySession.isStudying = true
            appState.studySession.endTime = endTime
            appState.studySession.remainingTime = remainingTime
        }
        
        subscription = timer.sink { [weak appState] _ in
            appState?[\.studySession.remainingTime] -= 1
        }
    }
    
    func endStudy() {
        appState[\.studySession.isStudying] = false
        subscription?.cancel()          
        
        let startTime = appState.value.studySession.startTime
        let endTime = Date()
        
        studySessionRepository
            .uploadStudyRecord(startTime: startTime, endTime: endTime)
            .sink { _ in
            } receiveValue: { _ in
            }
            .store(in: cancleBag)
    }
    
    func addTime() {
        appState.bulkUpdate { appState in
            appState.studySession.endTime += .init(minutes: 1)
            appState.studySession.remainingTime += .init(minutes: 1)
        }
    }
    
    func setStartTime(_ startTime: Date) {
        appState[\.studySession.startTime] = startTime
    }
}
