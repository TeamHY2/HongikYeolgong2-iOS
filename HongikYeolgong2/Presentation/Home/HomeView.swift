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
    
    var body: some View {
        VStack {
            WeeklyStudyView(studyRecords: studyRecords)
            
            StudyContentControllerView(studySession: $studySession)
            
            Spacer()
            
            ActionButtonControllerView(
                studySession: $studySession,
                actions: .init(
                    endButtonTapped: { studySessionInteractor.endStudy() },
                    startButtonTapped: { studySessionInteractor.startStudy() },
                    seatButtonTapped: {},
                    extensionButtonTapped: {}
                )
            )
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .modifier(GradientBackground())
        .onAppear { permissions.request(permission: .localNotifications) }
        .onAppear { studySessionInteractor.getWeekyStudy(studyRecords: $studyRecords) }
        .onReceive( studySessionUpdated) { studySession = $0 }
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
                    StudyPeriodView()
                    StudyTimerView()
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
        let extensionButtonTapped: () -> Void
    }
    
    var body: some View {
        Group {
            if studySession.isStudying {
                ActionButton(
                    title: "열람실 이용 종료",
                    backgroundColor: .gray600,
                    radius: 4,
                    action: { actions.endButtonTapped() }
                )
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
