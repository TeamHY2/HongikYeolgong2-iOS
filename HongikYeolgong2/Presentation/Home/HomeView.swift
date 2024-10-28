//
//  HomeView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI
import Combine

struct HomeView: View {
    // MARK: - Properties
    @Environment(\.injected.appState) var appState
    @Environment(\.injected.interactors.userPermissionsInteractor) var permissions
    @Environment(\.injected.interactors.studySessionInteractor) var studySessionInteractor
    
    @State private var studyRecords = [WeeklyStudyRecord]()
    @State private var studySession = AppState.StudySession()
    @State private var shouldShowTimePicker = false
    @State private var shouldShowAddTimeModal = false
    @State private var shouldShowEndUseModal = false
    
    var body: some View {
        VStack {
            WeeklyStudyView(studyRecords: studyRecords)
            
            StudyContentControllerView(studySession: $studySession)
            
            Spacer()
            
            ActionButtonControllerView(
                studySession: $studySession,
                actions: .init(
                    endButtonTapped: { shouldShowEndUseModal = true },
                    startButtonTapped: { shouldShowTimePicker = true },
                    seatButtonTapped: {},
                    addButtonTapped: { shouldShowAddTimeModal = true }
                )
            )
        }
        .systemOverlay(isPresented: $shouldShowTimePicker) {
            TimePickerView(
                selectedTime: Binding(
                    get: { appState.value.studySession.startTime },
                    set: { studySessionInteractor.setStartTime($0) }
                ),
                onTimeSelected: {
                    studySessionInteractor.startStudy()
                    shouldShowTimePicker = false
                }
            )        
        }
        .systemOverlay(isPresented: $shouldShowAddTimeModal) {
            ModalView(title: "열람실 이용 시간을 연장할까요?",
                      confirmButtonText: "연장하기",
                      cancleButtonText: "아니오",
                      confirmAction: {
                studySessionInteractor.addTime()
                shouldShowAddTimeModal = false
            },
            cancleAction: { shouldShowAddTimeModal = false })
        }
        .systemOverlay(isPresented: $shouldShowEndUseModal) {
            ModalView(title: "열람실을 다 이용하셨나요?",
                      confirmButtonText: "네",
                      cancleButtonText: "더 이용하기",
                      confirmAction: {
                studySessionInteractor.endStudy()
                shouldShowEndUseModal = false
                DispatchQueue.main.async {
                    studySessionInteractor.getWeekyStudy(studyRecords: $studyRecords)
                }
            },
            cancleAction: { shouldShowEndUseModal = false })
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .modifier(GradientBackground())
        .onAppear { permissions.request(permission: .localNotifications) }
        .onAppear { studySessionInteractor.getWeekyStudy(studyRecords: $studyRecords) }
        .onReceive(studySessionUpdated) { studySession = $0 }
    }
}

// MARK: - Publishers
extension HomeView {
    var studySessionUpdated: AnyPublisher<AppState.StudySession, Never> {
        appState.updates(for: \.studySession)
    }
}

// MARK: - StudyContentControllerView
struct StudyContentControllerView: View {
    @Binding var studySession: AppState.StudySession
    
    var body: some View {
        Group {
            if studySession.isStudying {
                VStack(spacing: 32.adjustToScreenHeight) {
                    StudyPeriodView(
                        startTime: studySession.startTime,
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
                TodayWiseSaying()
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
                        ActionButton(
                            title: "열람실 이용 연장",
                            backgroundColor: .blue100,
                            radius: 4,
                            action: { actions.addButtonTapped() }
                        )
                    }
                    ActionButton(
                        title: "열람실 이용 종료",
                        backgroundColor: .gray600,
                        radius: 4,
                        action: { actions.endButtonTapped() }
                    )
                }
            } else {
                HStack(spacing: 12.adjustToScreenWidth) {
                    ActionButton(
                        width: 69.adjustToScreenWidth,
                        backgroundColor: .clear,
                        action: {}
                    )
                    .modifier(ImageBackground(imageName: .seatButton))
                    
                    ActionButton(
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
