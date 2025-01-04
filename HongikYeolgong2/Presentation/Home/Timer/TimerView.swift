//
//  TimerView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/4/25.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
           VStack(alignment: .leading, spacing: 0) {
               Text("Time Left")
                   .font(.suite(size: 12, weight: .medium), lineHeight: 15)
                   .foregroundStyle(.gray300)
               
               Text("남은시간")
                   .font(.suite(size: 30, weight: .black), lineHeight: 32)
                   .foregroundColor(.white)
                   .padding(.top, 11)
               
               LinearProgressView(shape: Rectangle(), value: 1)
                   .frame(height: 8)
                   .padding(.top, 16)
           }
       }
}

struct LinearProgressView<Shape: SwiftUI.Shape>: View {
    var shape: Shape
    let value: Double
    
    var body: some View {
        VStack {
            shape.fill(.gray600)
                .overlay(alignment: .leading) {
                    GeometryReader { proxy in
                        shape.fill(.blue100)
                            .frame(width: proxy.size.width * value)
                    }
                }
        }
        .animation(.easeInOut, value: value)
    }
}

#Preview {
    TimerView()
}
