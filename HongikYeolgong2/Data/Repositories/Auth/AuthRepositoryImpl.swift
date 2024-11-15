//
//  AuthRepositoryImpl.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation
import Combine

final class AuthRepositoryImpl: AuthRepository {
    
    ///  소셜로그인
    /// - Parameter loginReqDto: 로그인 요청 DTO(이메일, identityToken)
    /// - Returns: 로그인 응답 DTO(accessToken, 가입여부)
    func signIn(loginReqDto: LoginRequestDTO) -> AnyPublisher<LoginResponseDTO, NetworkError> {        
        return Future<LoginResponseDTO, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<LoginResponseDTO> = try await NetworkService.shared.request(endpoint: AuthEndpoint.login(loginReqDto: loginReqDto))
                    promise(.success(response.data))
                } catch let error as NetworkError {                 
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// 닉네임 중복체크
    /// - Parameter nickname: 닉네임
    /// - Returns: 중복체크 여부
    func checkUserNickname(nickname: String) -> AnyPublisher<Bool, NetworkError> {
        return Future<Bool, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<NicknameCheckDTO> = try await NetworkService.shared.request(endpoint: UserEndpoint.checkUserNickname(nickname: nickname))                    
                    promise(.success(response.data.duplicate))
                } catch let error as NetworkError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// 회원가입을 요청합니다.
    /// - Parameter signUpReqDto: 회원가입 요청 DTO(닉네임, 학과)
    /// - Returns: 회원가입 응답 DTO(유저정보)
    func signUp(signUpReqDto: SignUpRequestDTO) -> AnyPublisher<SignUpResponseDTO, NetworkError> {
        return Future<SignUpResponseDTO, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<SignUpResponseDTO> = try await NetworkService.shared.request(endpoint: UserEndpoint.signUp(signUpReqDto: signUpReqDto))
                    promise(.success(response.data))
                } catch let error as NetworkError {                    
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// - Returns: 내정보 조회
    func getUser() -> AnyPublisher<SignUpResponseDTO,  NetworkError> {
        return Future<SignUpResponseDTO, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<SignUpResponseDTO> = try await NetworkService.shared.request(endpoint: UserEndpoint.getUser)
                    promise(.success(response.data))
                } catch let error as NetworkError {         
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
        
    /// 토큰유효성 검사를 진행합니다.
    /// - Returns: USERROLE, 유효성 여부
    func validToken() -> AnyPublisher<TokenValidResponseDTO, NetworkError> {
        return Future<TokenValidResponseDTO, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<TokenValidResponseDTO> = try await NetworkService.shared.request(endpoint: TokenEndpoint.validToken)
                    promise(.success(response.data))
                } catch let error as NetworkError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /// UserProfile을 받아옵니다.
    /// - Returns: 학과, 닉네임 등의 유저정보
    func getUserProfile() -> AnyPublisher<UserProfile, NetworkError> {
        return Future<UserProfile, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<UserProfile> = try await NetworkService.shared.request(endpoint: UserEndpoint.getUserProfile)
                    promise(.success(response.data))
                } catch let error as NetworkError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func withdraw() -> AnyPublisher<Void, NetworkError> {
        return Future<Void, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<WithdrawResponseDTO> = try await NetworkService.shared.request(endpoint: AuthEndpoint.withdraw)
                    promise(.success(()))
                } catch let error as NetworkError {                    
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
