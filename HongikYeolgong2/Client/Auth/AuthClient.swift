//
//  AuthClient.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/7/25.
//

import Foundation
import Dependencies

struct AuthClient {
    var requestSignIn: () async throws -> (identityToken: String, email: String)
}

extension AuthClient: DependencyKey {
    static let liveValue = Self(
        requestSignIn: {
            return try await AppleLoginManager().requestSignIn()
        }
    )
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
