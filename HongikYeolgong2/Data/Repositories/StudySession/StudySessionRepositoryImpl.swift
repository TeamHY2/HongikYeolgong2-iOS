//
//  WeeklyStudyRepositoryImpl.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation
import Combine

final class StudySessionRepositoryImpl: StudySessionRepository {
    func getWeeklyStudyRecords() -> AnyPublisher<[WeeklyStudySessionDTO], NetworkError> {
        return Future<[WeeklyStudySessionDTO], NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<[WeeklyStudySessionDTO]> = try await NetworkService.shared.request(endpoint: WeeklyEndpoint.getWeeklyStudy)
                    promise(.success(response.data))
                } catch let error as NetworkError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
}
