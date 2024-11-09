//
//  AuthRepository.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Combine

protocol AuthRepository {
    func signIn(loginReqDto: LoginRequestDTO) -> AnyPublisher<LoginResponseDTO, NetworkError>
    func signUp(signUpReqDto: SignUpRequestDTO) -> AnyPublisher<SignUpResponseDTO, NetworkError>
    func checkUserNickname(nickname: String) -> AnyPublisher<Bool, NetworkError>
    func getUser() -> AnyPublisher<SignUpResponseDTO, NetworkError>
    func validToken() -> AnyPublisher<TokenValidResponseDTO, NetworkError>
    func getUserProfile() -> AnyPublisher<UserProfile, NetworkError>
}
