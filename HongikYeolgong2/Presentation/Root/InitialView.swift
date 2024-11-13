//
//  InitialView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import SwiftUI
import Combine

struct InitialView: View {
    @Environment(\.injected.appState) var appState
    @Environment(\.injected.interactors.userDataInteractor) var userDataInteractor
    @Environment(\.injected.interactors.userPermissionsInteractor) var userPermissionsInteractor
    
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
                    .onAppear { checkUserSession() }
            }
        }
        .onAppear {
            resolveUserPermissions()
        }
        .onReceive(canRequestFirstPushPermissions) { _ in            
            requestUserPushPermissions()
        }
        .onReceive(userSessionUpdated) {
            userSession = $0
        }
    }
}

private extension InitialView {
    var userSessionUpdated: AnyPublisher<AppState.UserSession, Never> {
        appState.updates(for: \.userSession)
    }
    
    var canRequestFirstPushPermissions: AnyPublisher<Void, Never> {
        appState.updates(for: \.permissions.push)
            .filter { $0 == .notRequested }
            .map { _ in }
            .eraseToAnyPublisher()
    }
}

private extension InitialView {
    func checkUserSession() {
        userDataInteractor.checkAuthentication()
    }
    
    func resolveUserPermissions() {
        userPermissionsInteractor.resolveStatus(for: .localNotifications)
    }
    
    func requestUserPushPermissions() {
        userPermissionsInteractor.request(permission: .localNotifications)
    }
}

#Preview {
    InitialView()
}
