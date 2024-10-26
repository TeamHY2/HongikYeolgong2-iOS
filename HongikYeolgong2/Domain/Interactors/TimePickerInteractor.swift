//
//  TimePickerInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/26/24.
//

import SwiftUI
import Combine

// MARK: - Protocol
protocol TimePickerInteractor {
   func updateTime(hour: Binding<Int>, minute: Binding<Int>)
   func changedTime(
       hour: Binding<Int>,
       minute: Binding<Int>,
       newHour: Int,
       newMinute: Int,
       beforeHour: Int,
       beforeMinute: Int
   )
}

// MARK: - Implementation
final class TimePickerInteractorImpl: TimePickerInteractor {
   // MARK: - Properties
   private let calendar = Calendar.current
   private let cancleBag = CancelBag()
   
   // MARK: - Public Methods
   func updateTime(hour: Binding<Int>, minute: Binding<Int>) {
       let currentHour = calendar.component(.hour, from: .now)
       let currentMinutes = calendar.component(.minute, from: .now)
       
       hour.wrappedValue = currentHour
       minute.wrappedValue = currentMinutes
   }
   
   func changedTime(
       hour: Binding<Int>,
       minute: Binding<Int>,
       newHour: Int,
       newMinute: Int,
       beforeHour: Int,
       beforeMinute: Int
   ) {
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
               hour,
               beforeValue: beforeHour,
               currentValue: currentHour,
               newValue: newHour,
               componentToUpdate: &newDateComponents.hour
           )
           updateComponentIfNeeded(
               minute,
               beforeValue: beforeMinute,
               currentValue: currentMinute,
               newValue: newMinute,
               componentToUpdate: &newDateComponents.minute
           )
       } else {
           updateComponentIfChanged(
               hour,
               beforeValue: beforeHour,
               newValue: newHour,
               componentToUpdate: &newDateComponents.hour
           )
           updateComponentIfChanged(
               minute,
               beforeValue: beforeMinute,
               newValue: newMinute,
               componentToUpdate: &newDateComponents.minute
           )
       }
   }
   
   // MARK: - Private Methods
   /// DateComponentes의 업데이트 여부에 따라서 값을 업데이트 합니다.
   private func updateComponentIfNeeded(
       _ binding: Binding<Int>,
       beforeValue: Int,
       currentValue: Int,
       newValue: Int,
       componentToUpdate: inout Int?
   ) {
       if beforeValue != newValue || newValue > currentValue {
           binding.wrappedValue = currentValue
           componentToUpdate = currentValue
       }
   }
   
   /// DateComponentes의 업데이트 여부에 따라서 값을 업데이트 합니다.
   private func updateComponentIfChanged(
       _ binding: Binding<Int>,
       beforeValue: Int,
       newValue: Int,
       componentToUpdate: inout Int?
   ) {
       if beforeValue != newValue {
           binding.wrappedValue = newValue
           componentToUpdate = newValue
       }
   }
}
