//
//  RankingDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import Foundation

protocol RankingDataInteractor {
    func getCurrentWeekField()
}

final class RankingDataInteractorImpl: RankingDataInteractor {
    let studySessionRepository: StudySessionRepository
    let weeklyRepository: WeeklyRepository
    let cancleBag = CancelBag()
    
    init(studySessionRepository: StudySessionRepository, weeklyRepository: WeeklyRepository) {
        self.studySessionRepository = studySessionRepository
        self.weeklyRepository = weeklyRepository
    }
    
    func getCurrentWeekField() {
        weeklyRepository
            .getWeekField(date: Date().toDateString())
            .sink { _ in
                
            } receiveValue: { _ in
                
            }
            .store(in: cancleBag)
    }
}
