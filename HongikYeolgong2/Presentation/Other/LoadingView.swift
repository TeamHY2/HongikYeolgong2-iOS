//
//  LoadingView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/10/24.
//

import SwiftUI

struct LoadingView: View {
    @State var currentDegress = 0.0
    @State var currentShape = 0.0
    @State var shapeResuve: Bool = true
    @State private var isAnimating: Bool = false
    
    let colors = LinearGradient(gradient: Gradient(colors: [.blue100, .blue200, .blue300, .blue400]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: currentShape)
            .stroke(colors, style: StrokeStyle(lineWidth: 8, lineCap: .round))
            .frame(width: 40, height: 40)
            .rotationEffect(Angle(degrees: currentDegress))
            .onAppear {
                if !isAnimating { // 애니메이션이 실행 중이 아닐 때만 실행 -> 누적 방지
                    isAnimating = true
                    Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                        withAnimation {
                            self.currentDegress += shapeResuve ? 2 : 6
                            self.currentShape = shapeResuve ? currentShape + 0.008 : currentShape - 0.01
                            if currentShape > 1 {
                                self.shapeResuve = false
                            } else if currentShape < 0.01 {
                                self.shapeResuve = true
                            }
                        }
                    }
                }
            }
    }
}

#Preview {
    LoadingView()
}
