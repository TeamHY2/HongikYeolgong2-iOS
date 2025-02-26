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
    
    // 랭킹 기준 날짜
    var baseDate: Date = Date()
    
    init(studySessionRepository: StudySessionRepository, weeklyRepository: WeeklyRepository) {
        self.studySessionRepository = studySessionRepository
        self.weeklyRepository = weeklyRepository
    }
    
    /// 현재 주차의 주간 랭킹을 가져오는 메서드
    /// - Parameter weeklyRanking: 주간 랭킹 데이터 리스트
    func getCurrentWeeklyRanking(weeklyRanking: Binding<WeeklyRanking>) {
        let weekNumber = getWeekOfYear(date: baseDate)
        
        studySessionRepository
            .getWeeklyRanking(weekNumber: weekNumber)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: {
                weeklyRanking.wrappedValue = $0
            }
            .store(in: cancleBag)
    }
    
    /// 다음 주차의 주간 랭킹을 가져오는 메서드
    /// - Parameter weeklyRanking: 주간 랭킹 데이터 리스트
    func getNextWeeklyRanking(weeklyRanking: Binding<WeeklyRanking>) {
        // 기존 날짜 +1주일
        let weekNumber = changeWeek(by: 1)
        
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
    func getPreviosWeeklyRanking(weeklyRanking: Binding<WeeklyRanking>) {
        // 기존 날짜 -1주일
        let weekNumber = changeWeek(by: -1)
        
        studySessionRepository
            .getWeeklyRanking(weekNumber: weekNumber)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: {
                weeklyRanking.wrappedValue = $0
            }
            .store(in: cancleBag)
    }
    
    // 연도별 주차 추출 (24년 10주차 -> 202410 형태)
    func getWeekOfYear(date: Date) -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        
        let weekOfYear = calendar.component(.weekOfYear, from: date)
        let year = calendar.component(.yearForWeekOfYear, from: date)
        
        print("weekNumber: \(year * 100 + weekOfYear)")
        return year * 100 + weekOfYear
    }
    
    // 주차 이동 후 연도별 주차 반환
    func changeWeek(by offset: Int) -> Int {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        baseDate = calendar.date(byAdding: .weekOfYear, value: offset, to: baseDate) ?? baseDate
        
        print("baseDate: \(baseDate)")
        return getWeekOfYear(date: baseDate)
    }
}
