//
//  HomeView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import Combine
import SwiftUI

import AmplitudeSwift

struct HomeView: View {
    // MARK: - Properties
    @Environment(\.injected.appState) var appState
    @Environment(\.injected.interactors.userPermissionsInteractor) var permissions
    @Environment(\.injected.interactors.studySessionInteractor) var studySessionInteractor
    @Environment(\.injected.interactors.weeklyStudyInteractor) var weeklyStudyInteractor
    
    @State private var studySession = AppState.StudySession()
    @State private var studyRecords: Loadable<[WeeklyStudyRecord]> = .notRequest
    @State private var wiseSaying: Loadable<WiseSaying> = .notRequest    
    @State private var shouldShowTimePicker = false
    @State private var shouldShowAddTimeModal = false
    @State private var shouldShowEndUseModal = false
    @State private var shouldShowWebView = false
        
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - WeeklyStudyCount
            WeeklyStudyView(studyRecords: studyRecords.value ?? [WeeklyStudyRecord]())
            Spacer().frame(height: 36.adjustToScreenHeight)
            // MARK: - WiseSaying
            if studySession.isStudying {
                StudyPeriodView(
                    startTime: studySession.firstStartTime,
                    endTime: studySession.endTime
                )
                Spacer().frame(height: 32.adjustToScreenHeight)
                StudyTimerView(
                    totalTime: studySession.totalTime,
                    remainingTime: studySession.remainingTime,
                    color: studySession.isAddTime ? .yellow100 : .white
                )
            } else {
                // TODO: 모든 로딩이 끝났을떄 동시에 컨텐츠 보여주기
                Spacer().frame(height: 120.adjustToScreenHeight)
                TodayWiseSaying(wiseSaying: wiseSaying.value ?? WiseSaying())
            }
            
            Spacer()
            
            // MARK: - Buttons
            Group {
                if studySession.isStudying {
                    
                    if studySession.isAddTime {
                        BaseButton(
                            title: "열람실 이용 연장",
                            backgroundColor: .blue100,
                            radius: 4,
                            action: addButtonTapped
                        )
                    }
                    BaseButton(
                        title: "열람실 이용 종료",
                        backgroundColor: .gray600,
                        radius: 4,
                        action: endButtonTapped
                    )
                    Spacer().frame(height: 12.adjustToScreenHeight)
                } else {
                    HStack {
                        BaseButton(
                            width: 69.adjustToScreenWidth,
                            backgroundColor: .clear,
                            action: seatButtonTapped
                        )
                        .modifier(ImageBackground(imageName: .seatButton))
                        Spacer().frame(width: 12.adjustToScreenWidth)
                        BaseButton(
                            backgroundColor: .clear,
                            action: startButtonTapped
                        )
                        .modifier(ImageBackground(imageName: .startButton))
                    }
                }
            }
            
            Spacer().frame(height: 36.adjustToScreenHeight)
        }
        .systemOverlay(isPresented: $shouldShowTimePicker) {
            TimePickerView(
                selectedTime: Binding(
                    get: { appState.value.studySession.startTime },
                    set: { studySessionInteractor.setStartTime($0) }
                ),
                onTimeSelected: startStudy
            )
        }
        .systemOverlay(isPresented: $shouldShowAddTimeModal) {
            ModalView(isPresented: $shouldShowAddTimeModal,
                      title: "열람실 이용 시간을 연장할까요?",
                      confirmButtonText: "연장하기",
                      cancleButtonText: "아니오",
                      confirmAction: { studySessionInteractor.addTime() })
        }
        .systemOverlay(isPresented: $shouldShowEndUseModal) {
            ModalView(isPresented: $shouldShowEndUseModal,
                      title: "열람실을 다 이용하셨나요?",
                      confirmButtonText: "네",
                      cancleButtonText: "더 이용하기",
                      confirmAction: endStudy )
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .modifier(IOSBackground())
        .onAppear {
            weeklyStudyInteractor.getWeekyStudy(studyRecords: $studyRecords)
            weeklyStudyInteractor.getWiseSaying(wiseSaying: $wiseSaying)
        }
        .onReceive(studySessionUpdated) {
            studySession = $0
        }
        .onReceive(studySessionEnded) { _ in
            endStudy()
        }
        .onReceive(studySessionUploaded) { _ in
            weeklyStudyInteractor.getWeekyStudy(studyRecords: $studyRecords)
        }
        .onReceive(scenePhaseUpdated) {
            $0 == .active
            ? studySessionInteractor.resumeStudy()
            : studySessionInteractor.pauseStudy()
        }
    }
}

// MARK: - Helpers
extension HomeView {
    func endButtonTapped() {
        shouldShowEndUseModal.toggle()
    }
    
    func startButtonTapped() {
        shouldShowTimePicker.toggle()
    }
    
    func seatButtonTapped() {
        
    }
    
    func addButtonTapped() {
        shouldShowAddTimeModal.toggle()
        Amplitude.instance.track(eventType: "StudyExtendButton")
    }
    
    func startStudy() {
        studySessionInteractor.startStudy()
        weeklyStudyInteractor.addStarCount(studyRecords: $studyRecords)
        Amplitude.instance.track(eventType: "StudyStartButton")
    }
    
    func endStudy() {
        studySessionInteractor.endStudy()
        Amplitude.instance.track(eventType: "StudyEndButton")
    }
    
    func retryAction() {
        weeklyStudyInteractor.getWeekyStudy(studyRecords: $studyRecords)
        weeklyStudyInteractor.getWiseSaying(wiseSaying: $wiseSaying)
    }
}

// MARK: - Publishers
extension HomeView {
    var studySessionUpdated: AnyPublisher<AppState.StudySession, Never> {
        appState.updates(for: \.studySession)
    }
    
    var studySessionEnded: AnyPublisher<TimeInterval, Never> {
        appState.updates(for: \.studySession.remainingTime)
            .dropFirst()
            .filter { $0 <= 0 }
            .eraseToAnyPublisher()
    }
    
    var scenePhaseUpdated: AnyPublisher<ScenePhase, Never> {
        appState.updates(for: \.system.scenePhase)
            .dropFirst()
            .filter { $0 != .inactive && studySession.isStudying }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    var studySessionUploaded: AnyPublisher<Void, Never> {
        appState.updates(for: \.studySession.isStudying)
            .dropFirst()
            .filter { !$0 }
            .delay(for: 1, scheduler: RunLoop.main)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
