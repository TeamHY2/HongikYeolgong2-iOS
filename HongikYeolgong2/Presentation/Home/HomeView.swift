//
//  HomeView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/3/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
                .frame(height: 32)
            WeeklyStudy()
            Spacer()
                .frame(height: 120)
//            Quote()
            TimerView()
            Spacer()
            HStack(spacing: 12) {
                BaseButton(width: 69, backgroundColor: .clear, action: {})
                    .modifier(ImageBackground(imageName: .seatButton))
                
                BaseButton(backgroundColor: .clear, action: {})
                    .modifier(ImageBackground(imageName: .startButton))
            }
            Spacer().frame(height: 36)
        }
        .padding(.horizontal, 32)
        .modifier(IOSBackground())
    }
}

#Preview {
    HomeView()
}
