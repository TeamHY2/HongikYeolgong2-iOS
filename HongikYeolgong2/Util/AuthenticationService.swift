//
//  AuthenticationService.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation
import AuthenticationServices

class AuthenticationService: NSObject, ASAuthorizationControllerDelegate {
    func requestAppleLogin(_ authorization: ASAuthorization) -> (String, String)? {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential,
              let idTokenData = appleIDCredential.identityToken,
              let idToken = String(data: idTokenData, encoding: .utf8) else {
            return nil
        }
        
        let email = appleIDCredential.email ?? ""
      
        return (email, idToken)
    }
}
