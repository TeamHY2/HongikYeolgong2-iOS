//
//  TimePickerView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/26/24.
//

import SwiftUI
import Combine

struct TimePickerView: View {
    private let calendar = Calendar.current    
    @Binding var selectedTime: Date
    @State private var hour = 0
    @State private var minute = 0
    @State private var beforeHour = 0
    @State private var beforeMinute = 0
    let onTimeSelected: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 0) {
            Text("열람실 이용 시작 시간")
                .font(.pretendard(size: 18, weight: .bold),
                      lineHeight: 22.adjustToScreenHeight)
                .foregroundColor(.gray100)
                .padding(.top, 40.adjustToScreenHeight)
            
            HStack {
                TimePicker(selected: $hour, data: makeHourData())
                Text(":")
                    .font(.suite(size: 24, weight: .bold), lineHeight: 30.adjustToScreenHeight)
                    .foregroundStyle(.white)
                TimePicker(selected: $minute, data: makeMinuteData())
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
                Button(action: {
                    
                }, label: {
                    Text("취소")
                        .font(.pretendard(size: 16, weight: .bold),
                              lineHeight: 26.adjustToScreenHeight)
                        .foregroundStyle(.gray200)
                        .frame(maxWidth: .infinity,
                               maxHeight: 46.adjustToScreenHeight)
                })
                .background(.gray600)
                .cornerRadius(8)
                
                Button(action: {
                    onTimeSelected?()                    
                }, label: {
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
        .onAppear { setInitialTime() }
        .onChange(of: hour) { checkTimeValidate($0, minute) }
        .onChange(of: minute) { checkTimeValidate(hour, $0) }
    }
}

private extension TimePickerView {
    
    func setInitialTime() {
        let currentHour = calendar.component(.hour, from: .now)
        let currentMinutes = calendar.component(.minute, from: .now)
        
        hour = currentHour
        minute = currentMinutes
    }
    
    func checkTimeValidate(_ newHour: Int, _ newMinute: Int) {
        let minimumDate = calendar.date(byAdding: .hour, value: -3, to: .now)
        let currentDateComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: .now
        )
        var newDateComponents = calendar.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: .now
        )
        
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
            // 24로 나눈 새로운 시간을 적용
            newDateComponents.hour = adjustHour
            // 현재로부터 1일전으로 적용
            newDateComponents.day = currentDay - 1
        }
        
        guard let newDate = calendar.date(from: newDateComponents),
              let minimumDate = minimumDate else {
            return
        }
        
        let isDescending = newDate > minimumDate
        let isAscending = newDate < .now
        
        if !isDescending || !isAscending {
            updateComponentIfNeeded(
                &hour,
                beforeValue: beforeHour,
                currentValue: currentHour,
                newValue: newHour,
                componentToUpdate: &newDateComponents.hour
            )
            updateComponentIfNeeded(
                &minute,
                beforeValue: beforeMinute,
                currentValue: currentMinute,
                newValue: newMinute,
                componentToUpdate: &newDateComponents.minute
            )
        } else {
            updateComponentIfChanged(
                &hour,
                beforeValue: beforeHour,
                newValue: newHour,
                componentToUpdate: &newDateComponents.hour
            )
            updateComponentIfChanged(
                &minute,
                beforeValue: beforeMinute,
                newValue: newMinute,
                componentToUpdate: &newDateComponents.minute
            )
        }
        
        selectedTime = calendar.date(from: newDateComponents)!
    }
    
    func updateComponentIfNeeded(
        _ binding: inout Int,
        beforeValue: Int,
        currentValue: Int,
        newValue: Int,
        componentToUpdate: inout Int?
    ) {
        if beforeValue != newValue || newValue > currentValue {
            binding = currentValue
            componentToUpdate = currentValue
        }
    }
    
    func updateComponentIfChanged(
        _ binding: inout Int,
        beforeValue: Int,
        newValue: Int,
        componentToUpdate: inout Int?
    ) {
        if beforeValue != newValue {
            binding = newValue
            componentToUpdate = newValue
        }
    }
    func makeHourData() -> [Int] {
        Array(repeating: Array(0...23), count: 100).flatMap { $0 }
    }
    
    func makeMinuteData() -> [Int] {
        Array(repeating: Array(0...59), count: 100).flatMap { $0 }
    }
}
