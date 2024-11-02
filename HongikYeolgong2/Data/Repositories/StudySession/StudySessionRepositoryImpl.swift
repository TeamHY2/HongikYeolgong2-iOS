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
    
    func getWiseSaying() -> AnyPublisher<WiseSaying, NetworkError> {
        return Future<WiseSaying, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<WiseSaying> = try await NetworkService.shared.request(endpoint: WeeklyEndpoint.getWiseSaying)
                    promise(.success(response.data))
                } catch let error as NetworkError {
                    print(error.message)
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func getWeeklyRanking(yearWeek: Int) -> AnyPublisher<WeeklyRanking, NetworkError> {
        return Future<WeeklyRanking, NetworkError> { promise in
            Task {
                do {
                    let response: BaseResponse<WeeklyRankingResponseDTO> = try await NetworkService.shared.request(endpoint: WeeklyEndpoint.getWeeklyRanking(yearWeek: yearWeek))
                    promise(.success(response.data.toEntity()))
                } catch let error as NetworkError {
                    print(error.message)
                }
            }
        }.eraseToAnyPublisher()
    }
}
