//
//  AuthRepositoryImpl.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {
    
    /// 소셜로그인
    func signIn(loginReqDto: LoginRequestDTO) async throws {
        do {                        
            let response: String = try await NetworkService.shared.request(endpoint: AuthEndpoint.login(loginReqDto))
        } catch {
            print("\(#function + error.localizedDescription))")
            throw error
        }
        
    }
}
