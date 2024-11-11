//
//  SocialLoginRepository.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/11/24.
//

import Combine

final class SocialLoginRepositoryImpl: SocialLoginRepository {
    func requestASToken(asTokenRequestDto: ASTokenRequestDTO) -> AnyPublisher<ASTokenResponseDTO, NetworkError> {
        return Future<ASTokenResponseDTO, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<ASTokenResponseDTO> = try await NetworkService.shared.request(endpoint: ASAuthEndpoint.requestToken(asTokenRequestDto))
                    print(response.data)
                    promise(.success(response.data))
                }
                catch let error as NetworkError {
                    print(error.message)
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
