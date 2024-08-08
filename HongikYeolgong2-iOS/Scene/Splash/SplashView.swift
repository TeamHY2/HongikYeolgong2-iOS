//
//  SplashView.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/8/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color(.customBackground)
                .ignoresSafeArea()
            Text("스플래쉬뷰")
                .foregroundStyle(.white)
                .font(.title)
        }
    }
}

#Preview {
    SplashView()
}
