//
//  TimePicker.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/8/24.
//

import SwiftUI

struct TimePickerDialog: View {
    @State private var hour = 0
    @State private var minutes = 0
    private let hourData = Array(repeating: Array(1...12), count: 100).flatMap { $0 }
    private let minutesData = Array(repeating: Array(0...59), count: 100).flatMap { $0 }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("열람실 이용 시작 시간")
                .font(.pretendard(size: 18, weight: .bold),
                      lineHeight: 22.adjustToScreenHeight)
                .foregroundColor(.gray100)
                .padding(.top, 40.adjustToScreenHeight)
            
            HStack {                
                TimePicker(selected: $hour, data: hourData)
                Text(":")
                    .font(.suite(size: 24, weight: .bold), lineHeight: 30.adjustToScreenHeight)
                    .foregroundStyle(.white)
                TimePicker(selected: $minutes, data: minutesData)
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
    }
}


#Preview {
    TimePickerDialog()
}
