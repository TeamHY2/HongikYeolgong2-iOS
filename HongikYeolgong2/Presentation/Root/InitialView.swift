//
//  InitialView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import SwiftUI
import Combine

struct InitialView: View {
    @Environment(\.injected) var injected: DIContainer
    
    @State private var appLaunchState: AppState.AppLaunchState = .checkAuthentication
    
    var body: some View {
//        NavigationView {
//            switch appLaunchState {
//            case .notAuthenticated:
//                OnboardingView()                    
//            case .authenticated:
//                MainTabView()
//            case .checkAuthentication:
//                SplashView()
//                    .ignoresSafeArea(.all)
//                    .onAppear(perform: appLaunchCompleted)
//            }
//        }
//        .navigationViewStyle(.stack)
//        .onReceive(isAppLaunchStateUpdated) { appLaunchState = $0 }
        SignUpView()
    }
}

private extension InitialView {
    var isAppLaunchStateUpdated: AnyPublisher<AppState.AppLaunchState, Never> {
        injected.appState.updates(for: \.appLaunchState)
    }
}

private extension InitialView {
    func appLaunchCompleted() {
        injected.interactors.userDataInteractor.getUser()
    }
}

#Preview {
    InitialView()
}
