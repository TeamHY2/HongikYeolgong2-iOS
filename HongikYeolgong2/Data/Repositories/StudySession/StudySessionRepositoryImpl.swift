//
//  WeeklyStudyRepositoryImpl.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation
import Combine

final class StudySessionRepositoryImpl: StudySessionRepository {
    func getWeeklyStudyRecords() -> AnyPublisher<[WeeklyStudyRecord], NetworkError> {
        return Future<[WeeklyStudyRecord], NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<[WeeklyStudySessionDTO]> = try await NetworkService.shared.request(endpoint: WeeklyEndpoint.getWeeklyStudy)                    
                    promise(.success(response.data.map { $0.toEntity() }))
                    
                } catch let error as NetworkError {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func uploadStudyRecord(startTime: Date, endTime: Date) -> AnyPublisher<StudySessionResponseDTO, NetworkError> {
        return Future<StudySessionResponseDTO, NetworkError> { promise in
            Task {
                do {
                    let studySessionReqDto = StudySessionRequestDTO(startTime: startTime.dateToISO8601(), endTime: endTime.dateToISO8601())
                    let _: BaseResponse<StudySessionResponseDTO> = try await NetworkService.shared.request(endpoint: WeeklyEndpoint.uploadStudySession(studySessionReqDto))
                } catch let error as NetworkError {
                    throw error
                }
            }
        }.eraseToAnyPublisher()
    }
}
