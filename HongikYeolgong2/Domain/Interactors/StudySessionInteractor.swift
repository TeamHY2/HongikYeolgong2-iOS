//
//  WeeklyStudyInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import SwiftUI
import Combine

protocol StudySessionInteractor {    
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
        
    /// 스터디세션을 시작합니다.
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
        
    /// 스터디세션을 종료하고 열람실 이용정보를 서버에 업로드합니다.
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
        
    /// 열람실 이용시간을 연장합니다.
    func addTime() {
        appState.bulkUpdate { appState in
            appState.studySession.endTime += .init(minutes: 1)
            appState.studySession.remainingTime += .init(minutes: 1)
        }
    }
        
    /// 열람실 이용 시작시간을 설정합니다.
    /// - Parameter startTime: 시작시간
    func setStartTime(_ startTime: Date) {
        appState[\.studySession.startTime] = startTime
    }
}
