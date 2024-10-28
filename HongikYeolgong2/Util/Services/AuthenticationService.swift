//
//  AuthenticationService.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation
import AuthenticationServices

protocol AuthenticationService {
    func requestAppleLogin(_ authrization: ASAuthorization) -> (email: String, idToken: String)?
}

final class AuthenticationServiceImpl: AuthenticationService {
    
    /// 애플로그인 요청을 위한 이메일과 토큰을 반환합니다.(이메일은 첫로그인시 반환)
    /// - Parameter authorization: authorization
    /// - Returns: email, identityToken
    func requestAppleLogin(_ authorization: ASAuthorization) -> (email: String, idToken: String)? {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let idTokenData = appleIDCredential.identityToken,
              let idToken = String(data: idTokenData, encoding: .utf8) else {
            return nil
        }
        
        let email = appleIDCredential.email ?? "kwons4163@naver.com"
        
        return (email: email, idToken: idToken)
    }
}
