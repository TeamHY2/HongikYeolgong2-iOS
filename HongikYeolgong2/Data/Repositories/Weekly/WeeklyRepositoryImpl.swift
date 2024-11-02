//
//  WeeklyRepositoryImpl.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import Combine

final class WeeklyRepositoryImpl: WeeklyRepository {
    func getWeekField(date: String) -> AnyPublisher<Int, NetworkError> {
        return Future<Int, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<WeekFieldResponseDTO> = try await NetworkService.shared.request(endpoint: WeeklyEndpoint.getWeekField(date: date))
                    promise(.success(response.data.weekNumber))
                } catch let error as NetworkError {
                    print(error.message)
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
