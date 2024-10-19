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
    func signIn(loginReqDto: LoginRequestDTO) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { promise in
            Task {
                do {
                    let response: BaseResponse<LoginResponseDTO> = try await NetworkService.shared.request(endpoint: AuthEndpoint.login(loginReqDto: loginReqDto))
                    promise(.success(response.code == 200))
                } catch {
                    promise(.failure(error))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func checkUserNickname(nickname: String) -> AnyPublisher<Bool, any Error> {
        return Future<Bool, Error> { promise in
            Task {
                do {
                    let response: BaseResponse<NicknameCheckDTO> = try await NetworkService.shared.request(endpoint: UserEndpoint.checkUserNickname(nickname: nickname))
                    promise(.success(response.data?.duplicate ?? true))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
