//
//  TimePickerView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/26/24.
//

import SwiftUI
import Combine

struct TimePickerView: View {
    @Environment(\.injected.interactors.timePickerInteractor) var timePickerInteractor
    @State private var hour = 0
    @State private var minute = 0
    @State private var beforeHour = 0
    @State private var beforeMinute = 0
    
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
                
                Button(action: {
                    
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
        .onAppear {
            timePickerInteractor.updateTime(hour: $hour,
                                            minute: $minute)
        }
        .onChange(of: [hour, minute], perform: {
            timePickerInteractor.changedTime(hour: $hour,
                                             minute: $minute,
                                             newHour: $0[0],
                                             newMinute: $0[1],
                                             beforeHour: beforeHour,
                                             beforeMinute: beforeMinute)
        })
    }
}

extension TimePickerView {
    func makeHourData() -> [Int] {
        Array(repeating: Array(0...23), count: 100).flatMap { $0 }
    }
    
    func makeMinuteData() -> [Int] {
        Array(repeating: Array(0...59), count: 100).flatMap { $0 }
    }
}
