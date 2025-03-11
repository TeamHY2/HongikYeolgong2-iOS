//
//  RankingDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import SwiftUI
import Combine

protocol RankingDataInteractor {
    func getWeeklyRanking()
}

final class RankingDataInteractorImpl: RankingDataInteractor, ObservableObject {
    let studySessionRepository: StudySessionRepository
    let weeklyRepository: WeeklyRepository
    let cancleBag = CancelBag()
    
    @Published var weeklyRanking: WeeklyRanking = WeeklyRanking()
    @Published var baseDate: Date = Date()
    
    init(studySessionRepository: StudySessionRepository, weeklyRepository: WeeklyRepository) {
        self.studySessionRepository = studySessionRepository
        self.weeklyRepository = weeklyRepository
    }
    
    /// 현재 주차의 주간 랭킹을 가져오는 메서드
    /// - Parameter weeklyRanking: 주간 랭킹 데이터 리스트
    func getWeeklyRanking() {
        let weekNumber = getWeekOfYear(date: baseDate)
        
        studySessionRepository
            .getWeeklyRanking(weekNumber: weekNumber)
            .receive(on: DispatchQueue.main)
            .sink { _ in }
            receiveValue: {
                self.weeklyRanking = $0
            }
            .store(in: cancleBag)
    }
    
    // 연도별 주차 추출 (24년 10주차 -> 202410 형태)
    func getWeekOfYear(date: Date) -> Int {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
        let weekOfYear = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.yearForWeekOfYear, from: date)
        
        print("weekNumber: \(year * 100 + weekOfYear)")
        return year * 100 + weekOfYear
    }
    
    // 주차 이동 후 랭킹 데이터 불러오기
    func changeWeek(by offset: Int) {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        baseDate = calendar.date(byAdding: .weekOfYear, value: offset, to: baseDate) ?? baseDate
        
        print("baseDate: \(baseDate)")
        // 주차 이동 후 데이터 불러오기
        getWeeklyRanking()
    }
    
    // 미래 주차 필터링
    func isNextWeekAvailable() -> Bool {
        let today = Date()
        return baseDate.formattedFullDate() != today.formattedFullDate()
    }
}
