//
//  WeeklyStudyRepositoryImpl.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation

final class StudySessionRepositoryImpl: StudySessionRepository {
    func getWeelyStudy() {
        Task {
            do {
                let response: BaseResponse<[WeeklyStudySessionDTO]> = try await NetworkService.shared.request(endpoint: WeeklyEndpoint.getWeeklyStudy)
                print(response.data)
            } catch let error as NetworkError {
                print(error.message)
            }
        }
    }
}
