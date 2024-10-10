//
//  TimePickerViewModel.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import SwiftUI
import Combine

final class TimePickerViewModel: ObservableObject {
    @Published var hour = 0
    @Published var minute = 0
    @Published var beforeHour = 0
    @Published var beforeMinute = 0
    
    private var cancleBag = Set<AnyCancellable>()
    
    private let calendar = Calendar.current
    
    init() {
        setInitialTime()
        observeTimeAndMinutes()
    }
    
    func setInitialTime() {
        let currentHour = calendar.component(.hour, from: .now)
        let currentMinutes = calendar.component(.minute, from: .now)
        hour = currentHour
        minute = currentMinutes
        beforeHour = currentHour
        beforeMinute = currentMinutes
    }
    
    func observeTimeAndMinutes() {
        Publishers.CombineLatest($hour, $minute)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (newHour, newMinute) in
                self?.updateTime(newHour: newHour, newMinute: newMinute)
            }
            .store(in: &cancleBag)
    }
    
    private func updateTime(newHour: Int, newMinute: Int) {
        let minimumDate = calendar.date(byAdding: .hour, value: -3, to: .now)
        let currentDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now)
        var newDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now)
        
        guard let currentHour = currentDateComponents.hour,
              let currentMinute = currentDateComponents.minute else {
            return
        }
        
        newDateComponents.hour = newHour
        newDateComponents.minute = newMinute
        
        let adjustHour = newHour % 24
        
        if let currentHour = currentDateComponents.hour,
           let currentDay = newDateComponents.day,
           currentHour <= 3,
           adjustHour > 21 {
            newDateComponents.hour = adjustHour
            newDateComponents.day = currentDay - 1
        }
        
        guard let newDate = calendar.date(from: newDateComponents),
              let minimumDate = minimumDate else { return }
        
        let isDescending = newDate > minimumDate
        let isAscending = newDate < .now
        
        if !isDescending || !isAscending {
            updateComponentIfNeeded(&hour, &beforeHour, currentHour, newHour, &newDateComponents.hour)
            updateComponentIfNeeded(&minute, &beforeMinute, currentMinute, newMinute, &newDateComponents.minute)
        } else {
            updateComponentIfChanged(&beforeHour, newHour, &newDateComponents.hour)
            updateComponentIfChanged(&beforeMinute, newMinute, &newDateComponents.minute)
        }
    }
    
    private func updateComponentIfNeeded(_ component: inout Int, _ beforeComponent: inout Int, _ currentValue: Int, _ newValue: Int, _ componentToUpdate: inout Int?) {
        if beforeComponent != newValue || newValue > currentValue {
            component = currentValue
            beforeComponent = currentValue
            componentToUpdate = currentValue
        }
    }
    
    private func updateComponentIfChanged(_ beforeComponent: inout Int, _ newValue: Int, _ componentToUpdate: inout Int?) {
        if beforeComponent != newValue {
            beforeComponent = newValue
            componentToUpdate = newValue
        }
    }
}
