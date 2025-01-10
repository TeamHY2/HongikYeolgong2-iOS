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
        var mainTab = MainTabFeature.State()
        var login = LoginFeature.State()
    }
    
    enum Action {
        case requestLogin
        case loginCompleted
        case mainTab(MainTabFeature.Action)
        case login(LoginFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.mainTab, action: \.mainTab) {
            MainTabFeature()
                ._printChanges()
        }
        Scope(state: \.login, action: \.login) {
            LoginFeature()
        }
        Reduce { state, action in
            switch action {
            case .requestLogin:
                return .run { send in
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                    await send(.loginCompleted)
                }
            case .mainTab(.setting(.logoutButtonTap)):
                state.loginState = .onboarding
                return .none
            case .login(.loginButtonTap):
                state.loginState = .home
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
