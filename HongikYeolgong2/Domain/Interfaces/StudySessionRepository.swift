//
//  WeeklyStudyRepository.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation
import Combine

protocol StudySessionRepository {
    func getWeeklyStudyRecords() -> AnyPublisher<[WeeklyStudyRecord], NetworkError>
    func uploadStudyRecord(startTime: Date, endTime: Date) -> AnyPublisher<StudySessionResponseDTO, NetworkError>
    func getWiseSaying() -> AnyPublisher<WiseSaying, NetworkError>
    func getWeeklyRanking(weekNumber: Int) -> AnyPublisher<WeeklyRanking, NetworkError>
    func getAllStudyRecords() -> AnyPublisher<[AllStudyRecord], NetworkError>
    func getStudyTime(date: Date) -> AnyPublisher<StudyTime, NetworkError>
}
