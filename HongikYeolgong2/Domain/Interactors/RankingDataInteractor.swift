//
//  RankingDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import SwiftUI

protocol RankingDataInteractor {
    func getCurrentWeekField(yearWeek: Binding<Int>)
    func getWeeklyRanking(yearWeek: Int, weeklyRanking: Binding<WeeklyRanking>)
}

final class RankingDataInteractorImpl: RankingDataInteractor {
    let studySessionRepository: StudySessionRepository
    let weeklyRepository: WeeklyRepository
    let cancleBag = CancelBag()
    
    init(studySessionRepository: StudySessionRepository, weeklyRepository: WeeklyRepository) {
        self.studySessionRepository = studySessionRepository
        self.weeklyRepository = weeklyRepository
    }
    
    
    /// 현재 날짜기준 주차정보를 받아옵니다 -> 202443(2024년 43주차 정보)
    /// - Parameter weekNumber: 주차정보
    func getCurrentWeekField(yearWeek: Binding<Int>) {
        weeklyRepository
            .getWeekField(date: Date().toDateString())
            .sink(receiveCompletion: {_ in}, receiveValue: {                
                yearWeek.wrappedValue = $0
            })
            .store(in: cancleBag)
    }
    
    /// 주차정보에 해당하는 랭킹데이터를 받아옵니다.
    /// - Parameters:
    ///   - yearWeek: 주차정보
    ///   - weeklyRanking: 랭킹데이터
    func getWeeklyRanking(yearWeek: Int, weeklyRanking: Binding<WeeklyRanking>) {
        studySessionRepository
            .getWeeklyRanking(yearWeek: yearWeek)
            .sink { _ in
                
            } receiveValue: {                
                weeklyRanking.wrappedValue = $0
            }
            .store(in: cancleBag)
    }
}
