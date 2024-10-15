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
