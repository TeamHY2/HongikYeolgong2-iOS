//
//  AuthenticationService.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Combine
import AuthenticationServices

enum AppleLoginError: Error {
    case typeError
}

protocol AppleLoginService {
    func requestAppleLogin(_ authrization: ASAuthorization) -> ASAuthorizationAppleIDCredential?
    func requestAppleLogin()
    func performExistingAccountSetupFlows() -> AnyPublisher<ASAuthorizationAppleIDCredential?, Error>
}

final class AppleLoginManager: NSObject, AppleLoginService, ASAuthorizationControllerDelegate, ASWebAuthenticationPresentationContextProviding, ASAuthorizationControllerPresentationContextProviding {
    private var appleLoginCompletion: ((Result<ASAuthorizationAppleIDCredential?, Error>) -> Void)?
    
    /// 애플로그인 요청을 위한 AppleIDCredential 을 반환합니다.
    /// - Parameter authorization: authorization
    /// - Returns: AppleIDCredential
    func requestAppleLogin(_ authorization: ASAuthorization) -> ASAuthorizationAppleIDCredential? {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return nil
        }
        
        return appleIDCredential
    }
    
    func requestAppleLogin() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
    }
    
    func performExistingAccountSetupFlows() -> AnyPublisher<ASAuthorizationAppleIDCredential?, Error> {
        return Future<ASAuthorizationAppleIDCredential?, Error> { [weak self] promise in
            guard let self = self else { return }
            let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                            ASAuthorizationPasswordProvider().createRequest()]
            
            // Create an authorization controller with the given requests.
            let authorizationController = ASAuthorizationController(authorizationRequests: requests)
            
            //            (Result<ASAuthorizationAppleIDCredential?, any Error>) -> Void
            
            appleLoginCompletion = promise
            
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }.eraseToAnyPublisher()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            appleLoginCompletion?(.failure(AppleLoginError.typeError))
            return
        }
        
        appleLoginCompletion?(.success(appleIDCredential))
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        appleLoginCompletion?(.failure(error))
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
