//
//  WeeklyStudyRepository.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation
import Combine

protocol StudySessionRepository {
    func getWeeklyStudyRecords() -> AnyPublisher<[WeeklyStudySessionDTO], NetworkError>
}
