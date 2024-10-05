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
                .padding(.top, 120)
            
            Spacer()
            Spacer()
            HStack(spacing: 12) {
                Button(action: {}) {
                    Text("좌석")
                        .frame(maxWidth: 69, minHeight: 52)
                        .font(.suite(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .background(Image(.seatButton))
                
                Button(action: {}) {
                    Text("열람실 이용 시작")
                        .frame(maxWidth: .infinity, minHeight: 52)
                        .font(.suite(size: 16, weight: .semibold))
                        .foregroundStyle(.white)
                }
                .background(Image(.startButton))
            }
            
            Spacer()
        }
        .padding(.horizontal, 32)
        .background(
            Image(.iOSBackground)
                .ignoresSafeArea(.all)
                .allowsHitTesting(false)
        )
    }
}

#Preview {
    HomeView()
}
