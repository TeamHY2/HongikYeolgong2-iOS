//
//  OnboardingFeature.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/4/25.
//

import Foundation
import ComposableArchitecture
import AuthenticationServices

@Reducer
struct OnboardingFeature {
    @ObservableState
    struct State {
        var tabIndex: Int = 0
    }
    
    enum Action {
        case setTabIndex(Int)
        case appleLoginRequested(ASAuthorizationAppleIDRequest)
        case appleLoginCompleted(Result<ASAuthorization, Error>)
    }
    
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .setTabIndex(let index):
                    state.tabIndex = index
                    return .none
                case .appleLoginRequested(let request):
                        request.requestedScopes = [.email]
                        return .none
                case .appleLoginCompleted(let result):
                    switch result {
                        case let .success(authorization):
                            return .none
                        case .failure:
                            return .none
                    }
                    
            }
        }
    }
    
    
    
}
