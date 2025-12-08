//
//  OnboardingView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/14/24.
//

import SwiftUI
import Combine
import AuthenticationServices

struct OnboardingView: View {
    // MARK: - Properties
    @Environment(\.injected.appState) private var appState
    @Environment(\.injected.interactors.userDataInteractor) var userDataInteractor
    
    @EnvironmentObject var router: AppRouter
    
    // MARK: - States
    @State private var routingState: Routing = .init()
    private var routingBinding: Binding<Routing> {
        $routingState.dispatched(to: appState, \.routing.onboarding)
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            Spacer()
            
            OnboardingPageView()
            
            AppleLoginButton(
                onRequest: onRequestAppleLogin,
                onCompletion: onCompleteAppleLogin
            )
        }
        .onReceive(routingUpdate) {
            DispatchQueue.main.async {
                router.push(to: .signUp)
                appState[\.routing.onboarding.signUp] = false
            }
        }
    }
}

// MARK: - Apple Login Methods
private extension OnboardingView {
    func onRequestAppleLogin(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.email]
    }
    
    func onCompleteAppleLogin(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case let .success(authorization):
           userDataInteractor.requestAppleLogin(authorization)
        case .failure:
            break
        }
    }
}

// MARK: - Routing
private extension OnboardingView {
    private var routingUpdate: AnyPublisher<Void, Never> {
        appState.updates(for: \.routing.onboarding.signUp)            
            .filter { $0 }
            .map { _ in }
            .eraseToAnyPublisher()
    }
}

extension OnboardingView {
    struct Routing: Equatable {
        var signUp: Bool = false
    }
}

