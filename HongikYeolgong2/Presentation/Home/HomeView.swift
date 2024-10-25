//
//  HomeView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @Environment(\.injected.interactors.userPermissionsInteractor) var permissions
    @Environment(\.injected.interactors.studySessionInteractor) var studySessionInteractor
    
    @State private(set) var studyRecords = [WeeklyStudyRecord]()
    @State private var studyRoomStatus = StudyRoomStatus()
    
    var body: some View {
        VStack {
            WeeklyStudyView(studyRecords: studyRecords)
            
            StudyContentControllerView(studyRoomStatus: studyRoomStatus)
            
            Spacer()
            
            ActionButtonControllerView(
                studyRoomStatus: studyRoomStatus,
                actions: .init(
                    endButtonTapped: {},
                    startButtonTapped: {},
                    seatButtonTapped: {},
                    extensionButtonTapped: {}
                )
            )
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .modifier(GradientBackground())
        .onAppear {
            permissions.request(permission: .localNotifications)
            studySessionInteractor.getWeekyStudy(studyRecords: $studyRecords)
        }
    }
}

extension HomeView {
    struct StudyRoomStatus {
        var isRoomInUse = false
    }
}

// MARK: - StudyContentControllerView
struct StudyContentControllerView: View {
    @State var studyRoomStatus: HomeView.StudyRoomStatus
    
    var body: some View {
        Group {
            if studyRoomStatus.isRoomInUse {
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
    @State var studyRoomStatus: HomeView.StudyRoomStatus
    let actions: ActionHandlers
    
    struct ActionHandlers {
        let endButtonTapped: () -> Void
        let startButtonTapped: () -> Void
        let seatButtonTapped: () -> Void
        let extensionButtonTapped: () -> Void
    }
    
    var body: some View {
        Group {
            if studyRoomStatus.isRoomInUse {
                ActionButton(
                    title: "열람실 이용 종료",
                    backgroundColor: .gray600,
                    radius: 4,
                    action: {}
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
                        action: {}
                    )
                    .modifier(ImageBackground(imageName: .startButton))
                }
            }
        }
        .padding(.bottom, 36.adjustToScreenHeight)
    }
}
