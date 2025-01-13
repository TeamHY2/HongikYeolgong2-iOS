//
//  RecordFeature.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/3/25.
//

import Foundation
import ComposableArchitecture

@Reducer
struct RecordFeature {
    @ObservableState
    struct State: Equatable {
        // 캘린더 관련 데이터
        var selectedDate: Date = Date()
        var allStudyRecords: [AllStudyRecord] = []
        var currentMonth: [Day] = []
        var isLoading: Bool = false
        
        var records:[record] = [
            record(title: "연간", hours: 0, minutes: 0),
            record(title: "이번학기", hours: 0, minutes: 0),
            record(title: "월간", hours: 0, minutes: 0),
            record(title: "투데이", hours: 0, minutes: 0)
        ]
    }
    
    enum Action {
        case onAppear
        case changeMonth(MoveType)
        case fetchRecords(Result<[AllStudyRecord], NSError>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .onAppear:
                    state.isLoading = true
                    return .none
                case .changeMonth(let moveType):
                    switch moveType {
                        case .current:
                            state.selectedDate = Date()
                        case .next:
                            state.selectedDate = Calendar.current.date(byAdding: .month, value: 1, to: state.selectedDate) ?? state.selectedDate
                        case .prev:
                            state.selectedDate = Calendar.current.date(byAdding: .month, value: -1, to: state.selectedDate) ?? state.selectedDate
                    }
                    state.currentMonth = generateMonth(for: state.selectedDate, records: state.allStudyRecords)
                    return .none
                    
                case .fetchRecords(.success(let records)):
                    state.isLoading = false
                    state.allStudyRecords = records
                    state.currentMonth = generateMonth(for: state.selectedDate, records: records)
                    return .none
                    
                case .fetchRecords(.failure):
                    state.isLoading = false
                    // 에러 처리 로직 추가
                    return .none
            }
        }
    }
    
    func generateMonth(for date: Date, records: [AllStudyRecord]) -> [Day] {
        var days: [Day] = []
        var count: Int = 1
        let calendar = Calendar.current

        let daysInMonth = calendar.range(of: .day, in: .month, for: date)!.count
        let firstDayOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!
        let startingSpace = calendar.dateComponents([.weekday], from: firstDayOfMonth).weekday! - 1

        while count <= 42 {
            if count <= startingSpace || count - startingSpace > daysInMonth {
                days.append(Day(dayOfNumber: ""))
            } else {
                let dayOfNumber = count - startingSpace
                let currentDate = calendar.date(byAdding: .day, value: dayOfNumber - 1, to: firstDayOfMonth)!

                let matchedRecords = records.filter {
                    calendar.isDate($0.date, inSameDayAs: currentDate)
                }
                days.append(Day(dayOfNumber: "\(dayOfNumber)", usageRecord: matchedRecords))
            }
            count += 1
        }
        return days
    }
}
