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
    private let addedTime: TimeInterval = .init(minutes: 1)
    
    private var subscription: AnyCancellable?
    
    init(appState: Store<AppState>,
         studySessionRepository: StudySessionRepository) {
        self.appState = appState
        self.studySessionRepository = studySessionRepository
    }
    
    /// 스터디세션을 시작합니다.
    func startStudy() {
        let startTime = appState.value.studySession.startTime
        let endTime = startTime + addedTime
        let remainingTime = endTime.timeIntervalSince(startTime)
        
        registerNotification(for: .extensionAvailable, endTimeInMinute: remainingTime)
        registerNotification(for: .urgent, endTimeInMinute: remainingTime)
        
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
        
        let startTime: Date = appState.value.studySession.startTime
        let endTime: Date = .now
        
        studySessionRepository
            .uploadStudyRecord(startTime: startTime, endTime: endTime)
            .sink { _ in
            } receiveValue: { _ in
            }
            .store(in: cancleBag)
        
        cancleAllNotification()
    }
    
    /// 열람실 이용시간을 연장합니다.
    func addTime() {
        appState.bulkUpdate { appState in
            appState.studySession.endTime += addedTime
            appState.studySession.remainingTime += addedTime
        }
                
        let remainingTime = appState.value.studySession.remainingTime
        
        cancleAllNotification()
        registerNotification(for: .extensionAvailable, endTimeInMinute: remainingTime)
        registerNotification(for: .urgent, endTimeInMinute: remainingTime)
    }
    
    /// 열람실 이용 시작시간을 설정합니다.
    /// - Parameter startTime: 시작시간
    func setStartTime(_ startTime: Date) {
        appState[\.studySession.startTime] = startTime
    }
    
    /// 열람실 이용종료 Notification을 등록합니다.
    func registerNotification(for type: StudyNotificationType, endTimeInMinute: TimeInterval) {
        let content = configuredNotificationContent(for: type)
        let trigger = configuredNotificationTrigger(for: type, endTime: endTimeInMinute)
        let request = UNNotificationRequest(
            identifier: "\(UUID().uuidString)",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    /// Notification Content 설정
    func configuredNotificationContent(for type: StudyNotificationType) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.body = type.message
        content.sound = .default
        return content
    }
    
    /// Notification Trigger 설정
    func configuredNotificationTrigger(for type: StudyNotificationType, endTime: TimeInterval) -> UNTimeIntervalNotificationTrigger? {
        let triggerTime = endTime - type.timeOffset
        
        assert(endTime - triggerTime == type.timeOffset, "잘못된 시간이 등록되었습니다.")
        assert(triggerTime > 0, "잔여 시간이 부족합니다. (필요: \(Int(type.timeOffset/60))분, 현재: \(Int(endTime/60))분)")
        
        guard triggerTime > 0 else {
            return nil
        }
        return UNTimeIntervalNotificationTrigger(timeInterval: triggerTime, repeats: false)
    }
    
    private func cancleAllNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
