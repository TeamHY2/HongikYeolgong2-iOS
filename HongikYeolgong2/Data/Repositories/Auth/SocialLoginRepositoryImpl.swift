//
//  SocialLoginRepository.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/11/24.
//

import Combine

final class SocialLoginRepositoryImpl: SocialLoginRepository {
    func requestASTokenRevoke(asRevokeTokenRequestDto: ASRevokeTokenRequestDTO) -> AnyPublisher<Void, NetworkError> {
        return Future<Void, NetworkError> { promise in
            Task {
                do {
                    let _ = try await NetworkService.shared.plainRequest(endpoint: ASAuthEndpoint.requestRevoke(asRevokeTokenRequestDto))
                    promise(.success(()))
                }
                catch let error as NetworkError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func requestASToken(asTokenRequestDto: ASTokenRequestDTO) -> AnyPublisher<ASTokenResponseDTO, NetworkError> {
        return Future<ASTokenResponseDTO, NetworkError> { promise in
            Task {
                do {
                    let response: ASTokenResponseDTO = try await NetworkService.shared.request(endpoint: ASAuthEndpoint.requestToken(asTokenRequestDto))
                    promise(.success(response))
                }
                catch let error as NetworkError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
