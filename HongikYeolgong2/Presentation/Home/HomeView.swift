//
//  HomeView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Properties
    @State private var isStudyStart: Bool = false
    @Environment(\.injected.interactors.studySessionInteractor) var studySessionInteracotr
    
    // MARK: - Body
    var body: some View {
        VStack {
            // 주간 열람실이용
            WeeklyStudy()
                .padding(.top, 33.adjustToScreenHeight)
                .onAppear {
                    studySessionInteracotr.getWeekyStudy()
                }
            
            // 오늘의 명언
            if isStudyStart {
                StudyPeriodView()
                    .padding(.top, 36.adjustToScreenHeight)
                StudyTimerView()
                    .padding(.top, 32.adjustToScreenHeight)
            } else {
                TodayWiseSaying()
                    .padding(.top, 120.adjustToScreenHeight)
            }
            
            Spacer()
            
            // 열람실 이용시작, 좌석버튼
            if isStudyStart {
                endButton
                    .padding(.bottom, 36.adjustToScreenHeight)
            } else {
                bottomButtons
                    .padding(.bottom, 36.adjustToScreenHeight)
            }
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .background(backgroundImage)
    }
    
    // MARK: - UI Components
    private var bottomButtons: some View {
        HStack(spacing: 12.adjustToScreenWidth) {
            seatButton
            startButton
        }        
    }
    
    private var seatButton: some View {
        Button(action: {}) {
            Text("좌석")
                .frame(width: 69.adjustToScreenWidth, height: 52.adjustToScreenHeight)
                .font(.suite(size: 16, weight: .semibold))
                .foregroundStyle(.white)
        }
        .background(
            Image(.seatButton)
                .resizable()
                .frame(maxWidth: .infinity,
                       minHeight: 52.adjustToScreenHeight)
        )
    }
    
    private var startButton: some View {
        Button(action: { isStudyStart = true }) {
            Text("열람실 이용 시작")
                .frame(maxWidth: .infinity,
                       minHeight: 52.adjustToScreenHeight)
                .font(.suite(size: 16, weight: .semibold))
                .foregroundStyle(.white)
        }
        .background(
            Image(.startButton)
                .resizable()
                .frame(maxWidth: .infinity,
                       minHeight: 52.adjustToScreenHeight)
        )
    }
    
    private var endButton: some View {
        Button(action: {}, label: {
            Text("열람실 이용 종료")
                .frame(maxWidth: .infinity,
                       minHeight: 52.adjustToScreenHeight)
                .font(.suite(size: 16, weight: .semibold))
                .foregroundStyle(.gray100)
        })
        .background(.gray600)
        .cornerRadius(4)
    }
    
    private var backgroundImage: some View {
        Image(.iOSBackground)
            .resizable()
            .ignoresSafeArea(.all)
            .frame(maxWidth: .infinity,
                   minHeight: SafeAreaHelper.getFullScreenHeight())
            .allowsHitTesting(false)
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
