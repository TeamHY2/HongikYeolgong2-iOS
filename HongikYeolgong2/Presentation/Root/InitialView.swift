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
    
    @State private var userSession: AppState.UserSession = .pending
    
    var body: some View {
        Group {
            switch userSession {
            case .unauthenticated:
                OnboardingView()
            case .authenticated:
                MainTabView()
            case .pending:
                SplashView()
                    .ignoresSafeArea(.all)
                    .onAppear(perform: appLaunchCompleted)
            }
        }
        .onReceive(isAppLaunchStateUpdated) { userSession = $0 }
    }
}

private extension InitialView {
    var isAppLaunchStateUpdated: AnyPublisher<AppState.UserSession, Never> {
        injected.appState.updates(for: \.userSession)
    }
}

private extension InitialView {
    func appLaunchCompleted() {
        injected.interactors.userDataInteractor.checkAuthentication()
    }
}

#Preview {
    InitialView()
}
