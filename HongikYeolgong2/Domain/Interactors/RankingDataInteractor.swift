//
//  RankingDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import SwiftUI
import Combine

protocol RankingDataInteractor {
    func getCurrentWeeklyRanking(weeklyRanking: Binding<WeeklyRanking>)
    func getNextWeeklyRanking(weeklyRanking: Binding<WeeklyRanking>)
    func getPreviosWeeklyRanking(weeklyRanking: Binding<WeeklyRanking>)
}

final class RankingDataInteractorImpl: RankingDataInteractor {
    let studySessionRepository: StudySessionRepository
    let weeklyRepository: WeeklyRepository
    let cancleBag = CancelBag()
    
    var weekNumber = 0
    var maxWeekNumber = 0
    var minWeekNumber = 0
    
    init(studySessionRepository: StudySessionRepository, weeklyRepository: WeeklyRepository) {
        self.studySessionRepository = studySessionRepository
        self.weeklyRepository = weeklyRepository
    }
    
    /// 현재 주차의 주간 랭킹을 가져오는 메서드
    /// - Parameter weeklyRanking: 주간 랭킹 데이터 리스트
    func getCurrentWeeklyRanking(weeklyRanking: Binding<WeeklyRanking>) {
        weeklyRepository
            .getWeekField(date: Date().toDateString())
            .flatMap({ [weak self] in
                guard let self = self else { return Empty<WeeklyRanking, NetworkError>().eraseToAnyPublisher() }
                weekNumber = $0
                maxWeekNumber = $0
                minWeekNumber = $0 - ($0 % 100)
                return studySessionRepository.getWeeklyRanking(weekNumber: weekNumber)
            })
            .first()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
            }, receiveValue: {
                weeklyRanking.wrappedValue = $0
            })
            .store(in: cancleBag)
    }
    
    /// 다음 주차의 주간 랭킹을 가져오는 메서드
    /// - Parameter weeklyRanking: 주간 랭킹 데이터 리스트
    /// - Note: 현재 주차(weekNumber)보다 큰 주차의 데이터는 조회할 수 없습니다.
    func getNextWeeklyRanking(weeklyRanking: Binding<WeeklyRanking>) {
        guard weekNumber < maxWeekNumber else { return }
        weekNumber += 1
        
        studySessionRepository
            .getWeeklyRanking(weekNumber: weekNumber)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: {
                weeklyRanking.wrappedValue = $0
            }
            .store(in: cancleBag)
    }
    
    /// 이전 주차의 주간 랭킹을 가져오는 메서드
    /// - Parameter weeklyRanking: 주간 랭킹 데이터 리스트
    /// - Note: 최소 주차(minWeekNumber)보다 작은 주차의 데이터는 조회할 수 없습니다.
    func getPreviosWeeklyRanking(weeklyRanking: Binding<WeeklyRanking>) {
        guard weekNumber > minWeekNumber else { return }
        weekNumber -= 1
        
        studySessionRepository
            .getWeeklyRanking(weekNumber: weekNumber)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: {
                weeklyRanking.wrappedValue = $0
            }
            .store(in: cancleBag)
    }
}
