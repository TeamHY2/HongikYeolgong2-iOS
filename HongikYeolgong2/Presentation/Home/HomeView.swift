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
    @State private var isShowTimePicker = false
    @State private var isShowAddTimeModal = false
    @State private var isShowEndUseModal = false
    @State private var isShowWebView = false
    @State private var isViewOnAppeared = false
    
    var body: some View {
        NetworkStateView(
            loadables: [
                AnyLoadable($studyRecords),
                AnyLoadable($wiseSaying)
            ],
            retryAction: retryAction
        ) {
            content
        }
    }
    
    var content: some View {
        NavigationStack {
            VStack(spacing: 0) {
                WeeklyStudyView(studyRecords: studyRecords.value ?? [WeeklyStudyRecord]())
                
                StudyContentControllerView(
                    studySession: $studySession,
                    wiseSaying: wiseSaying.value ?? WiseSaying()
                )
                
                Spacer()
                
                ActionButtonControllerView(
                    studySession: $studySession,
                    actions: .init(
                        endButtonTapped: endButtonTapped,
                        startButtonTapped: startButtonTapped,
                        seatButtonTapped: seatButtonTapped,
                        addButtonTapped: addButtonTapped
                    )
                )
            }
            .systemOverlay(isPresented: $isShowTimePicker) {
                TimePickerView(
                    selectedTime: Binding(
                        get: { appState.value.studySession.startTime },
                        set: { studySessionInteractor.setStartTime($0) }
                    ),
                    onTimeSelected: startStudy
                )
            }
            .systemOverlay(isPresented: $isShowAddTimeModal) {
                ModalView(isPresented: $isShowAddTimeModal,
                          title: "열람실 이용 시간을 연장할까요?",
                          confirmButtonText: "연장하기",
                          cancleButtonText: "아니오",
                          confirmAction: { studySessionInteractor.addTime() })
            }
            .systemOverlay(isPresented: $isShowEndUseModal) {
                ModalView(isPresented: $isShowEndUseModal,
                          title: "열람실을 다 이용하셨나요?",
                          confirmButtonText: "네",
                          cancleButtonText: "더 이용하기",
                          confirmAction: endStudy )
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
            .modifier(IOSBackground())

            .onAppear {
                if !isViewOnAppeared {
                    isViewOnAppeared = true
                    weeklyStudyInteractor.getWeekyStudy(studyRecords: $studyRecords)
                    weeklyStudyInteractor.getWiseSaying(wiseSaying: $wiseSaying)
                }
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
            .navigationDestination(for: Page.self, destination: { page in
                switch page {
                case let .webView(title, url):
                    WebViewWithNavigation(url: url, title: title)
                default:
                    EmptyView()
                }
            })
        }
    }
}

// MARK: - Helpers
extension HomeView {
    func endButtonTapped() {
        isShowEndUseModal.toggle()
    }
    
    func startButtonTapped() {
        isShowTimePicker.toggle()
    }
    
    func seatButtonTapped() {
        isShowWebView.toggle()
    }
    
    func addButtonTapped() {
        isShowAddTimeModal.toggle()
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
            .eraseToAnyPublisher()
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

// MARK: - StudyContentControllerView
struct StudyContentControllerView: View {
    @Binding var studySession: AppState.StudySession
    let wiseSaying: WiseSaying
    
    var body: some View {
        Group {
            if studySession.isStudying {
                VStack(spacing: 32.adjustToScreenHeight) {
                    StudyPeriodView(
                        startTime: studySession.firstStartTime,
                        endTime: studySession.endTime
                    )
                    StudyTimerView(
                        totalTime: studySession.totalTime,
                        remainingTime: studySession.remainingTime,
                        color: studySession.isAddTime ? .yellow100 : .white
                    )
                }
                .padding(.top, 36.adjustToScreenHeight)
            } else {
                TodayWiseSaying(wiseSaying: wiseSaying)
                    .padding(.top, 120.adjustToScreenHeight)
            }
        }
    }
}

// MARK: - ActionButtonControllerView
struct ActionButtonControllerView: View {
    @Binding var studySession: AppState.StudySession
    let actions: ActionHandlers
    
    struct ActionHandlers {
        let endButtonTapped: () -> Void
        let startButtonTapped: () -> Void
        let seatButtonTapped: () -> Void
        let addButtonTapped: () -> Void
    }
    
    var body: some View {
        Group {
            if studySession.isStudying {
                VStack(spacing: 12.adjustToScreenWidth) {
                    if studySession.isAddTime {
                        BaseButton(
                            title: "열람실 이용 연장",
                            backgroundColor: .blue100,
                            radius: 4,
                            action: { actions.addButtonTapped() }
                        )
                    }
                    BaseButton(
                        title: "열람실 이용 종료",
                        backgroundColor: .gray600,
                        radius: 4,
                        action: { actions.endButtonTapped() }
                    )
                }
            } else {
                HStack(spacing: 12.adjustToScreenWidth) {
                    BaseButton(
                        width: 69.adjustToScreenWidth,
                        backgroundColor: .clear,
                        action: { actions.seatButtonTapped() }
                    )
                    .modifier(ImageBackground(imageName: .seatButton))
                    
                    BaseButton(
                        backgroundColor: .clear,
                        action: { actions.startButtonTapped() }
                    )
                    .modifier(ImageBackground(imageName: .startButton))
                }
            }
        }
        .padding(.bottom, 36.adjustToScreenHeight)
    }
}
