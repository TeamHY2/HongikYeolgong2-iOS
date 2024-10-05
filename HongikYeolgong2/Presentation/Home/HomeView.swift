//
//  HomeView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            WeeklyStudy()
            
            TodayWiseSaying()
                .padding(.top, 120.adjustToScreenHeight)
            
            Spacer()
            Spacer()
            HStack(spacing: 12.adjustToScreenWidth) {
                Button(action: {}) {
                    Text("좌석")
                        .frame(width: 69.adjustToScreenWidth, height: 52.adjustToScreenHeight)
                        .font(.suite(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .background(Image(.seatButton)
                    .resizable()
                    .frame(maxWidth: .infinity,
                           minHeight: 52.adjustToScreenHeight))
                
                Button(action: {}) {
                    Text("열람실 이용 시작")
                        .frame(maxWidth: .infinity,
                               minHeight: 52.adjustToScreenHeight)
                        .font(.suite(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .background(Image(.startButton)
                    .resizable()
                    .frame(maxWidth: .infinity,
                           minHeight: 52.adjustToScreenHeight))
            }
            
            Spacer()
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .background(
            Image(.iOSBackground)
                .resizable()
                .ignoresSafeArea(.all)
                .frame(maxWidth: .infinity, minHeight: SafeAreaHelper.getFullScreenHeight())
                .allowsHitTesting(false)
        )
    }
}

#Preview {
    HomeView()
}
