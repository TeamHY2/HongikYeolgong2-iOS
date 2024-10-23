//
//  AuthRepositoryImpl.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation
import Combine

final class AuthRepositoryImpl: AuthRepository {
    
    /// 소셜로그인
    func signIn(loginReqDto: LoginRequestDTO) -> AnyPublisher<LoginResponseDTO, Error> {
        return Future<LoginResponseDTO, Error> { promise in
            Task {
                do {
                    let response: BaseResponse<LoginResponseDTO> = try await NetworkService.shared.request(endpoint: AuthEndpoint.login(loginReqDto: loginReqDto))
                    promise(.success(response.data!))
                } catch let error as NetworkError {
                    print(error.message)
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func checkUserNickname(nickname: String) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { promise in
            Task {
                do {
                    let response: BaseResponse<NicknameCheckDTO> = try await NetworkService.shared.request(endpoint: UserEndpoint.checkUserNickname(nickname: nickname))
                    promise(.success(response.data?.duplicate ?? false))
                } catch let error as NetworkError {
                    print(error.message)
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signUp(signUpReqDto: SignUpRequestDTO) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            Task {
                do {
                    let response: BaseResponse<SignUpResponseDTO> = try await NetworkService.shared.request(endpoint: UserEndpoint.signUp(signUpReqDto: signUpReqDto))
                    print(response.data)
                } catch let error as NetworkError {
                    print(error.message)
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
