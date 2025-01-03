//
//  AppFeature.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/3/25.
//

import Foundation
import ComposableArchitecture

enum LoginState {
    case home
    case onboarding
    case splash
}

@Reducer
struct AppFeature {
    @ObservableState
    struct State: Equatable {
        var loginState: LoginState = .splash
        var tabFeature = MainTabFeature.State()
    }
    
    enum Action {
        case login
        case loginCompleted
        case tabFeature(MainTabFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.tabFeature, action: \.tabFeature) {
            MainTabFeature()
                ._printChanges()
        }
        Reduce { state, action in
            switch action {
            case .login:
                return .run { send in
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                    await send(.loginCompleted)
                }
            case .tabFeature(.settingFeature(.logoutButtonTap)):
                state.loginState = .onboarding
                return .none
            case .loginCompleted:
                state.loginState = .home
                return .none
            default:
                return .none
            }
        }
    }
}
