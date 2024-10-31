//
//  RankingDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import Foundation

protocol RankingDataInteractor {}

final class RankingDataInteractorImpl: RankingDataInteractor {
    let studySessionRepository: StudySessionRepository
    let weeklyRepository: WeeklyRepository
    
    init(studySessionRepository: StudySessionRepository, weeklyRepository: WeeklyRepository) {
        self.studySessionRepository = studySessionRepository
        self.weeklyRepository = weeklyRepository
    }
}
