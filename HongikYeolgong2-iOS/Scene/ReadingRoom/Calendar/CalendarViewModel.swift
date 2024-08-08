//
//  CalendarViewModel.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/24/24.
//

import Foundation
import Combine

final class CalendarViewModel: ViewModelType {
    
    // MARK: - Input
    enum Action {
        case saveButtonTap(StudyRoomUsage, String)
        case moveButtonTap(MoveType)
        case getCalendar(String)
    }
    
    // MARK: - Action
    enum MoveType {
        case current
        case next
        case prev
    }
    
    // MARK: - Output
    @Published var seletedDate = Date() // 선택된 날짜
    @Published var currentMonth = [Day]() // 캘린더에 표시할 날짜정보
    @Published var todayStudyRoomUsageCount = 0 // 열람실 이용횟수
    @Published var studyRoomUsageList = [StudyRoomUsage]() // 서버에서 받아온 캘린더데이터
    
    // MARK: - Properties
    @Inject private var studyRoomRepository: StudyRoomRepositoryType
    
    private let calendar = Calendar.current
    
    private var subscriptions = Set<AnyCancellable>()
    
}

// MARK: - Binding
extension CalendarViewModel {
    /*
     Action을 받아서 Action의 타입에 따라서 메서드를 호출한다
     */
    func send(action: Action) {
        switch action {
        case .getCalendar(let email):
            fetchStudyRoomRecords(for: seletedDate, email: email)
        case .moveButtonTap(let moveType):
            changeMonth(moveType)
        case .saveButtonTap(let data, let email):
            updateStudyRoomRecord(data, email: email)
        }
    }
    
    /*
     캘린더달력 변경시 액션을 받아서 선택한달로 업데이트해준다
     캘린더데이터 리스트(studyRoomUsageList)에 저장된 데이터로 새로운 날짜데이터를 생성한다.
     */
    func changeMonth(_ moveType: MoveType) {
        var currentDate: Date!
        
        switch moveType {
        case .current:
            currentDate = Date()
        case .next:
            currentDate = plusMonth(date: seletedDate)
        case .prev:
            currentDate = minusMonth(date: seletedDate)
        }
        
        // 현재보다 더 미래의 월이 선택된 경우
        let maximumDateValidate = calendar.compare(currentDate, to: Date(), toGranularity: .month)
        
        // 날짜이동 최소값 날짜생성
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM"
        let minimumDate = formatter.date(from: "2021/01")!
        let mimumDateValidate = calendar.compare(currentDate, to: minimumDate, toGranularity: .month)
        
        guard maximumDateValidate != .orderedDescending,
              mimumDateValidate != .orderedAscending else {
            return
        }
        
        seletedDate = currentDate
        
        currentMonth = makeMonth(date: seletedDate, roomUsageInfo: studyRoomUsageList)
    }
    
    /*
     캘린더에 표시될 데이터를 새롭게 요청한다
     새롭게 받아온 데이터를 studyRoomUsageList에 저장한다
     */
    func fetchStudyRoomRecords(for date: Date, email: String) {
       studyRoomRepository.fetchStudyRoomUsageRecords(with: email)
            .receive(on: DispatchQueue.main)
            .withUnretained(self)
            .sink(receiveValue: { (owner, roomUsageInfo) in
                owner.currentMonth = owner.makeMonth(date: date, roomUsageInfo: roomUsageInfo)
                owner.studyRoomUsageList = roomUsageInfo
            })
            .store(in: &subscriptions)
    }

    /*
     새로운 캘린더데이터를(studyRoomUsage)를 서버에 업로드한다
     새롭게 받아온 데이터를 studyRoomUsageList에 저장한다
     */
    func updateStudyRoomRecord(_ studyRoomInfo: StudyRoomUsage, email: String) {
        studyRoomRepository.updateStudyRoomUsageRecord(studyRoomInfo, with: email)
            .receive(on: DispatchQueue.main)
            .withUnretained(self)
            .sink(receiveValue: { (owner, roomUsageInfo) in
                let studyRoomUsageCount = roomUsageInfo.filter { owner.calendar.isDate($0.date, equalTo: Date(), toGranularity: .day)}.count                
                owner.currentMonth = owner.makeMonth(date: owner.seletedDate, roomUsageInfo: roomUsageInfo)
                owner.studyRoomUsageList = roomUsageInfo
                owner.todayStudyRoomUsageCount = studyRoomUsageCount
            })
            .store(in: &subscriptions)    
    }
}

// MARK: - Helper
extension CalendarViewModel {
    
    // 현재보다 1달뒤에 날짜정보를 반환한다.
    func plusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    // 현재보다 1달전에 날짜정보를 반환한다.
    func minusMonth(date: Date) -> Date {
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    // 현재달에 몇일있는지를 반환한다.
    func daysInMonth(date: Date) -> Int {
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    // 현재달의 첫번째 달을 반환
    func firstOfMonth(date: Date) -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    // 무슨 요일인지 반환
    func weekDay(date: Date) -> Int {
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    // 캘린더뷰에 사용될 날짜배열을 생성하고 서버에서 받아온 캘린더데이터와 결합
    func makeMonth(date: Date, roomUsageInfo: [StudyRoomUsage]) -> [Day] {
        var days: [Day] = []
        var count: Int = 1
        
        let daysInMonth = daysInMonth(date: date)
        let firstDayOfMonth = firstOfMonth(date: date)
        let startingSpace = weekDay(date: firstDayOfMonth)
        
        while(count <= 42) {
            // 이번달이 아닌경우 공백 처리
            if (count <= startingSpace || count - startingSpace > daysInMonth) {
                days.append(Day(dayOfNumber: ""))
            }
            
            else {
                let numberOfDay = count - startingSpace
                
                guard calendar.date(byAdding: .day, value: numberOfDay - 1, to: firstOfMonth(date: date)) != nil else {
                    return []
                }
                // 현재날짜 생성
                var components = calendar.dateComponents([.year, .month, .day], from: date)
                components.day = numberOfDay
                
                // 현재날짜와 서버에서 받아온 데이터의 날짜가 일치하는지 확인
                if let currentDay = calendar.date(from: components) {
                    let matchData = roomUsageInfo.filter { calendar.isDate($0.date, inSameDayAs: currentDay)}
                    days.append(Day(dayOfNumber: "\(numberOfDay)", usageRecord: matchData))
                } else {
                    // 일치하는 데이터가 존재하지 않는경우
                    days.append(Day(dayOfNumber: "\(numberOfDay)"))
                }
                
            }
            count += 1
        }
        return days
    }
}
