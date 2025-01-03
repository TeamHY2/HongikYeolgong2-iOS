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
                MainTabView(store: store.scope(state: \.tabFeature, action: \.tabFeature))
            case .onboarding:
                Text("온보딩")
            case .splash:
                Text("스플래시")
                    .onAppear(perform: {
                        store.send(.login)
                    })
            }
        }
    }
}

//#Preview {
//    SwiftUIView()
//}
