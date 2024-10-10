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
    @Published var mimute = 0
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
        mimute = currentMinutes
        beforeHour = currentHour
        beforeMinute = currentMinutes
    }
    
    func observeTimeAndMinutes() {
        Publishers.CombineLatest($hour, $mimute)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (newHour, newMinute) in
                guard let self = self else { return }
                
                let minimumDate = calendar.date(byAdding: .hour, value: -3, to: .now)
                let currentDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now)
                var newDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now)
                
                newDateComponents.hour = newHour
                newDateComponents.minute = newMinute
                
                guard let currentHour = currentDateComponents.hour,
                      let currentMinute = currentDateComponents.minute,
                      let newDate = calendar.date(from: newDateComponents),
                      let minimumDate = minimumDate else { return }
                
                let isDescending = calendar.compare(newDate, to: minimumDate, toGranularity: .second) == .orderedDescending
                let isAscending = calendar.compare(newDate, to: .now, toGranularity: .second) == .orderedAscending
                
                if !isDescending || !isAscending {
                    if beforeHour != newHour || newHour > currentHour {
                        hour = currentHour
                        beforeHour = currentHour
                        newDateComponents.hour = currentHour
                    }
                    if beforeMinute != newMinute || newMinute > currentMinute {
                        mimute = currentMinute
                        beforeMinute = currentMinute
                        newDateComponents.minute = currentMinute
                    }
                } else {
                    if beforeHour != newHour {
                        beforeHour = newHour
                        newDateComponents.hour = newHour
                    }
                    if beforeMinute != newMinute {
                        beforeMinute = newMinute
                        newDateComponents.minute = newMinute
                    }
                }
                
                objectWillChange.send()
            }
            .store(in: &cancleBag)
    }
}
