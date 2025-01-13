//
//  SwiftUIView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 12/22/24.
//

import SwiftUI
import ComposableArchitecture

struct SwiftUIView: View {
    let store: StoreOf<AppFeature>
    var body: some View {
        WithPerceptionTracking {
            switch store.loginState {
            case .home:
                MainTabView(store: store.scope(state: \.mainTab, action: \.mainTab))
            case .onboarding:
                OnboardingView(store: store.scope(state: \.login, action: \.login))
            case .splash:
                Text("스플래시")
                    .onAppear(perform: {
                        store.send(.requestLogin)
                    })
            }
        }
    }
}

//#Preview {
//    SwiftUIView()
//}
