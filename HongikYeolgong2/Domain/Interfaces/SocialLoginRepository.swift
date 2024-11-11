//
//  SocialLoginRepository.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/11/24.
//

import Combine

protocol SocialLoginRepository {
    func requestASToken(asTokenRequestDto: ASTokenRequestDTO) -> AnyPublisher<ASTokenResponseDTO, NetworkError>
}
