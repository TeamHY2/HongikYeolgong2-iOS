//
//  TimePicker.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/8/24.
//

import SwiftUI
import Combine

struct TimePickerDialog: View {
    
    @Binding private var selectedDate: Date
    
    private let hourData = Array(repeating: Array(0...23), count: 100).flatMap { $0 }
    private let minutesData = Array(repeating: Array(0...59), count: 100).flatMap { $0 }
    
    @StateObject private var timePickerModel = TimePickerModel()
    
    init(selectedDate: Binding<Date>) {
        self._selectedDate = selectedDate
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("열람실 이용 시작 시간")
                .font(.pretendard(size: 18, weight: .bold),
                      lineHeight: 22.adjustToScreenHeight)
                .foregroundColor(.gray100)
                .padding(.top, 40.adjustToScreenHeight)
            
            HStack {
                TimePicker(selected: $timePickerModel.hour, data: hourData)
                Text(":")
                    .font(.suite(size: 24, weight: .bold), lineHeight: 30.adjustToScreenHeight)
                    .foregroundStyle(.white)
                TimePicker(selected: $timePickerModel.mimute, data: minutesData)
                
            }
            .frame(maxWidth: 94.adjustToScreenWidth)
            .frame(height: 126.adjustToScreenHeight)
            .mask(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .gray800.opacity(0), location: 0),
                        .init(color: .gray800, location: 0.33)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .mask(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .gray800.opacity(0), location: 0),
                        .init(color: .gray800, location: 0.33)
                    ]),
                    startPoint: .bottom,
                    endPoint: .top
                )
            )
            .clipped()
            .padding(.top, 30.adjustToScreenHeight)
            
            HStack(spacing: 12.adjustToScreenWidth) {
                Button(action: {}, label: {
                    Text("취소")
                        .font(.pretendard(size: 16, weight: .bold),
                              lineHeight: 26.adjustToScreenHeight)
                        .foregroundStyle(.gray200)
                        .frame(maxWidth: .infinity,
                               maxHeight: 46.adjustToScreenHeight)
                })
                .background(.gray600)
                .cornerRadius(8)
                
                Button(action: {}, label: {
                    Text("확인")
                        .font(.pretendard(size: 16, weight: .bold),
                              lineHeight: 26.adjustToScreenHeight)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity,
                               maxHeight: 46.adjustToScreenHeight)
                })
                .background(.blue100)
                .cornerRadius(8)
            }
            .padding(EdgeInsets(top: 42.adjustToScreenHeight,
                                leading: 32.adjustToScreenWidth,
                                bottom: 30.adjustToScreenHeight,
                                trailing: 32.adjustToScreenWidth))
        }
        .background(.gray800)
        .cornerRadius(8)
        .onAppear(perform: {
            let calendar = Calendar.current
            let currentHour = calendar.component(.hour, from: .now)
            let currentMinutes = calendar.component(.minute, from: .now)
            timePickerModel.hour = currentHour
            timePickerModel.mimute = currentMinutes
            timePickerModel.beforeHour = currentHour
            timePickerModel.beforeMinute = currentMinutes
            selectedDate = .now
        })
        .onReceive(Publishers.CombineLatest(timePickerModel.$hour.eraseToAnyPublisher(), timePickerModel.$mimute.eraseToAnyPublisher()), perform: { (newHour, newMinutes) in
          
            let calendar = Calendar.current
            let minimumDate = calendar.date(byAdding: .hour, value: -3, to: .now)
            let currentDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now)
            var newDateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: .now)
            
            newDateComponents.hour = newHour
            newDateComponents.minute = newMinutes
            
            guard let currentHour = currentDateComponents.hour,
                  let currentMinute = currentDateComponents.minute,
                  let newDate = calendar.date(from: newDateComponents),
                  let minimumDate = minimumDate else { return }
            
            let isDescending = calendar.compare(newDate, to: minimumDate, toGranularity: .second) == .orderedDescending
            let isAscending = calendar.compare(newDate, to: .now, toGranularity: .second) == .orderedAscending
            
            if !isDescending || !isAscending {
                if timePickerModel.beforeHour != newHour || newHour > currentHour {
                    timePickerModel.hour = currentHour
                    timePickerModel.beforeHour = currentHour
                    newDateComponents.hour = currentHour
                }
                if timePickerModel.beforeMinute != newMinutes || newMinutes > currentMinute {
                    timePickerModel.mimute = currentMinute
                    timePickerModel.beforeMinute = currentMinute
                    newDateComponents.minute = currentMinute
                }
            } else {
                if timePickerModel.beforeHour != newHour {
                    timePickerModel.beforeHour = newHour
                    newDateComponents.hour = newHour
                }
                if timePickerModel.beforeMinute != newMinutes {
                    timePickerModel.beforeMinute = newMinutes
                    newDateComponents.minute = newMinutes
                }
            }
            
            selectedDate = calendar.date(from: newDateComponents) ?? .now
        })
    }
}

final class TimePickerModel: ObservableObject {
    @Published var hour = 0
    @Published var mimute = 0
    @Published var beforeHour = 0
    @Published var beforeMinute = 0
}

#Preview {
    TimePickerDialog(selectedDate: .constant(.now))
}
