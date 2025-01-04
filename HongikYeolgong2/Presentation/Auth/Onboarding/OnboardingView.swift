//
//  OnboardingView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/4/25.
//

import SwiftUI
import ComposableArchitecture

struct OnboardingView: View {
    let store: StoreOf<OnboardingFeature>
    
    var body: some View {
        VStack {
            Spacer()
            
            TabView(selection: .init(get: {
                store.tabIndex
            }, set: {
                store.send(.setTabIndex($0))
            })){
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
                        if index == store.tabIndex {
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
            Button {
                print("")
            } label: {
                Image(.snsLogin)
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 52)
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
            .padding(.top, 32.adjustToScreenHeight)
            .padding(.bottom, 20.adjustToScreenHeight)
        }
    }
}

#Preview {
    OnboardingView(store: Store(initialState: OnboardingFeature.State()) {
        OnboardingFeature()
    })
}
