//
//  AppState.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import SwiftUI

final class AppState {
    var userData = UserData()
    var userSession: UserSession = .pending
    var studySession = StudySession()
    var routing = ViewRouting()
    var system = System()
    var permissions = Permissions()
}

extension AppState {
    /// 앱의 실행 상태를 나타냅니다.
    enum UserSession: Equatable {
        case unauthenticated
        case authenticated
        case pending
    }
}

extension AppState {
    /// 앱 전역에서 사용하는 유저데이터 입니다.
    struct UserData: Equatable {
        var isLoggedIn = false
    }
}

extension AppState {
    /// 열람실 이용상태를 관리하는 구조체 입니다.
    struct StudySession: Equatable {
        var isStudying = false
        var firstStartTime: Date = .now
        var startTime: Date = .now
        var endTime: Date = .now
        var remainingTime: TimeInterval = 0
        var minimumTime: TimeInterval = .init(minutes: 30)
        
        var isAddTime: Bool {
            remainingTime <= minimumTime
        }
        
        var totalTime: TimeInterval {
            endTime.timeIntervalSince(startTime)
        }
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        var onboarding = OnboardingView.Routing()
    }
}

extension AppState {
    struct System: Equatable {
        var isKeyboardActive = false      
        var scenePhase: ScenePhase = .active
    }
}

extension AppState {
    
    /// 접근권한 상태를 관리하는 구조체 입니다.
    struct Permissions: Equatable {
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

extension AppState: Equatable {
    static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.userData == rhs.userData &&
        lhs.routing == rhs.routing &&
        lhs.system == rhs.system &&
        lhs.permissions == rhs.permissions &&
        lhs.userData == rhs.userData &&
        lhs.userSession == rhs.userSession &&
        lhs.studySession == rhs.studySession
    }
}
