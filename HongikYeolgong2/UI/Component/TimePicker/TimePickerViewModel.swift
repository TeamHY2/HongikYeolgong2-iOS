//
//  TimePickerViewModel.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import SwiftUI
import Combine

final class TimePickerViewModel: ObservableObject {
    
    /// Picker에 표시될 시간(시)
    @Published var hour = 0
    
    /// Picker에 표시될 시간(분)
    @Published var minute = 0
    
    /// 이전에 선택된 Picker 시간체크(시)
    @Published var beforeHour = 0
    
    /// 이전에 선택된 Picker 시간체크(분)
    @Published var beforeMinute = 0        
    
    private var cancleBag = Set<AnyCancellable>()
    
    private let calendar = Calendar.current
    
    let hourData = Array(repeating: Array(0...23), count: 100).flatMap { $0 }
    let minutesData = Array(repeating: Array(0...59), count: 100).flatMap { $0 }
    
    init() {
        setInitialTime()
        observeTimeAndMinutes()
    }
    
    /// 초기시간을 설정하는 메서드 입니다.
    private func setInitialTime() {
        let currentHour = calendar.component(.hour, from: .now)
        let currentMinutes = calendar.component(.minute, from: .now)
        hour = currentHour
        minute = currentMinutes
        beforeHour = currentHour
        beforeMinute = currentMinutes
    }
    
    /// 시간(시, 분)을 관찰하고 업데이트 메서드를 트리거합니다.
    private func observeTimeAndMinutes() {
        Publishers.CombineLatest($hour, $minute)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (newHour, newMinute) in
                self?.updateTime(newHour: newHour, newMinute: newMinute)
            }
            .store(in: &cancleBag)
    }
    
    /// 새로운(시, 분)을 받아서 업데이트하는 메서드 입니다.
    private func updateTime(newHour: Int, newMinute: Int) {
        let minimumDate = calendar.date(byAdding: .hour, value: -3, to: .now)
        let currentDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now)
        var newDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now)
        
        // 현재시간(시, 분)
        guard let currentHour = currentDateComponents.hour,
              let currentMinute = currentDateComponents.minute else {
            return
        }
        
        // 새로운 시간으로 설정
        newDateComponents.hour = newHour
        newDateComponents.minute = newMinute
        
        let adjustHour = newHour % 24
        
        // 3시 이전 예외처리
        if let currentHour = currentDateComponents.hour,
           let currentDay = newDateComponents.day,
           currentHour <= 3,
           adjustHour > 21 {
            newDateComponents.hour = adjustHour // 24로 나눈 새로운 시간을 적용합니다.
            newDateComponents.day = currentDay - 1 // 현재로부터 1일전으로 적용
        }
        
        guard let newDate = calendar.date(from: newDateComponents),
              let minimumDate = minimumDate else { return }
        
        let isDescending = newDate > minimumDate
        let isAscending = newDate < .now
        
        // 정해진 시간범위에 속하지 않는경우
        if !isDescending || !isAscending {
            updateComponentIfNeeded(&hour, &beforeHour, currentHour, newHour, &newDateComponents.hour)
            updateComponentIfNeeded(&minute, &beforeMinute, currentMinute, newMinute, &newDateComponents.minute)
        } else {
            updateComponentIfChanged(&beforeHour, newHour, &newDateComponents.hour)
            updateComponentIfChanged(&beforeMinute, newMinute, &newDateComponents.minute)
        }
    }
    
    /// DateComponentes의 업데이트 여부에 따라서 값을 업데이트 합니다.
    private func updateComponentIfNeeded(_ component: inout Int, _ beforeComponent: inout Int, _ currentValue: Int, _ newValue: Int, _ componentToUpdate: inout Int?) {
        if beforeComponent != newValue || newValue > currentValue {
            component = currentValue
            beforeComponent = currentValue
            componentToUpdate = currentValue
        }
    }
    
    /// DateComponentes의 업데이트 여부에 따라서 값을 업데이트 합니다.
    private func updateComponentIfChanged(_ beforeComponent: inout Int, _ newValue: Int, _ componentToUpdate: inout Int?) {
        if beforeComponent != newValue {
            beforeComponent = newValue
            componentToUpdate = newValue
        }
    }
}
