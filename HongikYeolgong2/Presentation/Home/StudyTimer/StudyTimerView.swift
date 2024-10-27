//
//  StudyTimerView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/23/24.
//

import SwiftUI

struct StudyTimerView: View {
    let totalTime: TimeInterval
    let remainingTime: TimeInterval
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Time Left")
                .font(.suite(size: 12, weight: .medium), lineHeight: 15.adjustToScreenHeight)
                .foregroundStyle(.gray300)
            
            Text(remainingTime.getFullTime())
                .font(.suite(size: 30, weight: .black), lineHeight: 32.adjustToScreenHeight)
                .foregroundColor(color)
                .padding(.top, 11.adjustToScreenHeight)
            
            LinearProgressView(shape: Rectangle(), value: remainingTime / totalTime)
                .frame(height: 8.adjustToScreenHeight)
                .padding(.top, 16.adjustToScreenHeight)
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

