//
//  RankingDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import SwiftUI
import Combine

protocol RankingDataInteractor {
    func getWeeklyRanking(weeklyRanking: Binding<WeeklyRanking>, weekNumber: Int)
}

final class RankingDataInteractorImpl: RankingDataInteractor {
    let studySessionRepository: StudySessionRepository
    let weeklyRepository: WeeklyRepository
    let cancleBag = CancelBag()
    
    init(studySessionRepository: StudySessionRepository, weeklyRepository: WeeklyRepository) {
        self.studySessionRepository = studySessionRepository
        self.weeklyRepository = weeklyRepository
    }
    
    /// 현재 주차의 주간 랭킹을 가져오는 메서드
    /// - Parameter weeklyRanking: 주간 랭킹 데이터 리스트
    func getWeeklyRanking(weeklyRanking: Binding<WeeklyRanking>, weekNumber: Int) {
        studySessionRepository
            .getWeeklyRanking(weekNumber: weekNumber)
            .receive(on: DispatchQueue.main)
            .sink { _ in }
            receiveValue: {
                weeklyRanking.wrappedValue = $0
            }
            .store(in: cancleBag)
    }
}
