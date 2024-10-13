//
//  AuthRepository.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation

protocol AuthRepository {
    func signIn(loginReqDto: LoginRequestDTO) async throws
}
