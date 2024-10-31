//
//  RankingDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import SwiftUI

protocol RankingDataInteractor {
    func getCurrentWeekField(weekNumber: Binding<Int>)
    func getWeeklyRanking(yearWeek: Int)
}

final class RankingDataInteractorImpl: RankingDataInteractor {
    let studySessionRepository: StudySessionRepository
    let weeklyRepository: WeeklyRepository
    let cancleBag = CancelBag()
    
    init(studySessionRepository: StudySessionRepository, weeklyRepository: WeeklyRepository) {
        self.studySessionRepository = studySessionRepository
        self.weeklyRepository = weeklyRepository
    }
    
    func getCurrentWeekField(weekNumber: Binding<Int>) {
        weeklyRepository
            .getWeekField(date: Date().toDateString())
            .sink(receiveCompletion: {_ in}, receiveValue: {
                weekNumber.wrappedValue = $0
            })
            .store(in: cancleBag)
    }
    
    func getWeeklyRanking(yearWeek: Int) {
        
    }
}
