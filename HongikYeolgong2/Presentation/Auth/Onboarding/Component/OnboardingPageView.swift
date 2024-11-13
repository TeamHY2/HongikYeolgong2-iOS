//
//  OnboardingPageView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/12/24.
//

import SwiftUI

struct OnboardingPageView: View {
    @Binding var tabIndex: Int
    
    var body: some View {
        VStack {
            TabView(selection: $tabIndex) {
                Image(.onboarding01)
                    .tag(0)
                Image(.onboarding02)
                    .tag(1)
                Image(.onboarding03)
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack(spacing: 16.adjustToScreenWidth) {
                ForEach(0..<3, id: \.self) { index in
                    Group {
                        if index == tabIndex {
                            Image(.shineOnboarding)
                                .frame(width: 9, height: 9)
                        } else {
                            Circle()
                                .frame(width: 9, height: 9)
                                .foregroundColor(.gray600)
                        }
                    }
                }
            }
            
        }
    }
}

#Preview {
    OnboardingPageView(tabIndex: .constant(0))
}
