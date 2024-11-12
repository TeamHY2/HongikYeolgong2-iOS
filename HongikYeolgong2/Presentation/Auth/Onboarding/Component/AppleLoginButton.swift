//
//  AppleLoginButton.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/12/24.
//

import SwiftUI
import AuthenticationServices

struct AppleLoginButton: View {
    let onRequest: (ASAuthorizationAppleIDRequest) -> Void
    let onCompletion: (Result<ASAuthorization, any Error>) -> Void
    
    var body: some View {
        Button(action: {}) {
            Image(.snsLogin)
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: 52)
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .padding(.top, 32.adjustToScreenHeight)
        .padding(.bottom, 20.adjustToScreenHeight)
        .overlay(
            SignInWithAppleButton(
                onRequest: onRequest,
                onCompletion: onCompletion
            )
            .blendMode(.destinationOver)
        )
    }
}

#Preview {
    AppleLoginButton(onRequest: {_ in}, onCompletion: {_ in})
}
