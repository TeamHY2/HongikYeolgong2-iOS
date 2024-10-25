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
    @Environment(\.injected.interactors.studySessionInteractor) var studySessionInteracotr
    @State private(set) var studyRecords = [WeeklyStudyRecord]()
    @State private var isStudyStart: Bool = false
    
    // MARK: - Body
    var body: some View {
        content
            .onAppear { permissions.request(permission: .localNotifications) }
    }
}

// MARK: - Main Content Components
private extension HomeView {
    var content: some View {
        VStack {
            WeeklyStudyView(studyRecords: studyRecords)
                .padding(.top, 33.adjustToScreenHeight)
                .onAppear(perform: getWeeklyStudy)
            
            studyContent
            
            Spacer()
            
            actionButtons
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .background(backgroundImage)
    }
    
    var studyContent: some View {
        Group {
            if isStudyStart {
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
    
    var actionButtons: some View {
        Group {
            if isStudyStart {
                endButton
            } else {
                bottomButtons
            }
        }
        .padding(.bottom, 36.adjustToScreenHeight)
    }
}

// MARK: - Button Components
private extension HomeView {
    var bottomButtons: some View {
        HStack(spacing: 12.adjustToScreenWidth) {
            seatButton
            startButton
        }
    }
    
    var seatButton: some View {
        Button(action: {}) {
            Text("좌석")
                .frame(width: 69.adjustToScreenWidth, height: 52.adjustToScreenHeight)
                .font(.suite(size: 16, weight: .semibold))
                .foregroundStyle(.white)
        }
        .background(
            Image(.seatButton)
                .resizable()
                .frame(maxWidth: .infinity, minHeight: 52.adjustToScreenHeight)
        )
    }
    
    var startButton: some View {
        Button(action: { isStudyStart = true }) {
            Text("열람실 이용 시작")
                .frame(maxWidth: .infinity, minHeight: 52.adjustToScreenHeight)
                .font(.suite(size: 16, weight: .semibold))
                .foregroundStyle(.white)
        }
        .background(
            Image(.startButton)
                .resizable()
                .frame(maxWidth: .infinity, minHeight: 52.adjustToScreenHeight)
        )
    }
    
    var endButton: some View {
        Button(action: {}) {
            Text("열람실 이용 종료")
                .frame(maxWidth: .infinity, minHeight: 52.adjustToScreenHeight)
                .font(.suite(size: 16, weight: .semibold))
                .foregroundStyle(.gray100)
        }
        .background(.gray600)
        .cornerRadius(4)
    }
}

// MARK: - Background Components
private extension HomeView {
    var backgroundImage: some View {
        Image(.iOSBackground)
            .resizable()
            .ignoresSafeArea(.all)
            .frame(maxWidth: .infinity, minHeight: SafeAreaHelper.getFullScreenHeight())
            .allowsHitTesting(false)
    }
}

// MARK: - Interactions
extension HomeView {
    func getWeeklyStudy() {
        studySessionInteracotr
            .getWeekyStudy(studyRecords: $studyRecords)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
