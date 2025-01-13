//
//  AppleLoginManger.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/7/25.
//

import Foundation
import AuthenticationServices

class AppleLoginManager: NSObject, ASAuthorizationControllerDelegate { // Coordinator 클래스 생성
    private var continuation: CheckedContinuation<(identityToken: String, email: String), Error>?
    private var authorizationController: ASAuthorizationController?
    
    /// apple 로그인
    func requestSignIn() async throws -> (identityToken: String, email: String) {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation

            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.email]

            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self
            self.authorizationController = controller
            controller.performRequests()
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let credential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let identityTokenData = credential.identityToken,
              let identityToken = String(data: identityTokenData, encoding: .utf8)
        else {
            continuation?.resume(throwing: NSError(domain: "AppleLoginError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to get credentials"]))
            continuation = nil
            return
        }
        continuation?.resume(returning: (identityToken: identityToken, email: ""))
        continuation = nil
        self.authorizationController = nil
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        continuation?.resume(throwing: error)
        continuation = nil
        self.authorizationController = nil
    }
}
