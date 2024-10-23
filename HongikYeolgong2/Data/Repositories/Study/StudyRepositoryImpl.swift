//
//  StudyRepositoryImpl.swift
//  HongikYeolgong2
//
//  Created by 변정훈 on 10/22/24.
//

import Foundation
import Combine

final class StudyRepositoryImpl: StudyRepository {
    
    func studyCountAll() -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { promise in
            Task {
                do {
                    let response: BaseResponse<CountAllResDTO> = try await NetworkService.shared.request(endpoint: StudyEndpoint.countAll)
                    promise(.success(response.code == 200))
                } catch {
                    promise(.failure(error))
                }
            }
            
        }.eraseToAnyPublisher()
    }
}
