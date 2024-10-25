//
//  AppState.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import SwiftUI

final class AppState: ObservableObject {
    @Published var appLaunchState: AppLaunchState = .checkAuthentication
    @Published var userData = UserData()
    @Published var studySession = StudySession()
    @Published var routing = ViewRouting()
    @Published var permissions = Permissions()
}

extension AppState {
    enum AppLaunchState {
        case notAuthenticated
        case authenticated
        case checkAuthentication
    }
}

extension AppState {
    struct UserData: Equatable {
        var isLoggedIn = false
    }
}

extension AppState {
    struct StudySession: Equatable {
        var isStudying = false
        var startTime: Date = .now
        var endTime: Date = .now
        var remainingTime = 0
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        var onboarding = OnboardingView.Routing()
    }
}

extension AppState {
    struct Permissions {
        var push: Permission.Status = .unknown
    }
    
    // KeyPath를 반환하는 메서드
    static func permissionKeyPath(for permission: Permission) -> WritableKeyPath<AppState, Permission.Status> {
        let pathToPermissions = \AppState.permissions
        switch permission {
        case .localNotifications:
            return pathToPermissions.appending(path: \.push)
        }
    }
}
