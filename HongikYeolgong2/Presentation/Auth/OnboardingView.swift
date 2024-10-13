//
//  OnboardingView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.injected) var injected: DIContainer
    
    @State private var seletedIndex = 0
    @State private var isActive = false
    @State private var routingState: Routing = .init()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                TabView(selection: $seletedIndex) {
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
                            if index == seletedIndex {
                                Image(.shineCount02)
                                    .frame(width: 9, height: 9)
                            } else {
                                Circle()
                                    .frame(width: 9, height: 9)
                                    .foregroundColor(.gray600)
                            }
                        }
                    }
                }
                
                Button(action: {
                    isActive = true
                }, label: {
                    Image(.snsLogin)
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 52)
                })
                .padding(.horizontal, 32.adjustToScreenWidth)
                .padding(.top, 32.adjustToScreenHeight)
                .padding(.bottom, 20.adjustToScreenHeight)
                
                NavigationLink("SignIn", destination: SignInView(), isActive: $isActive)
                    .opacity(0)
                    .frame(width: 0, height: 0)
            }
        }
    }
}

extension OnboardingView {
    struct Routing: Equatable {
        var signUp: String?
    }
}

