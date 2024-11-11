//
//  AuthenticationService.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation
import AuthenticationServices

protocol AppleLoginManager {
    func requestAppleLogin(_ authrization: ASAuthorization) -> ASAuthorizationAppleIDCredential?
}

final class AuthenticationServiceImpl: AppleLoginManager {
    
    /// 애플로그인 요청을 위한 AppleIDCredential 을 반환합니다.
    /// - Parameter authorization: authorization
    /// - Returns: AppleIDCredential
    func requestAppleLogin(_ authorization: ASAuthorization) -> ASAuthorizationAppleIDCredential? {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return nil
        }
        
        return appleIDCredential
    }
}
