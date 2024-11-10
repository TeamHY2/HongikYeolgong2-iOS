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
    
    let colors = LinearGradient(gradient: Gradient(colors: [.blue100, .blue200, .blue300, .blue400]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    var body: some View {
        Circle()
            .trim(from: 0.0, to: currentShape)
            .stroke(colors, style: StrokeStyle(lineWidth: 8, lineCap: .round))
            .frame(width: 40, height: 40)
            .rotationEffect(Angle(degrees: currentDegress))
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    withAnimation {
                        self.currentDegress += 20
                        self.currentShape = shapeResuve ? currentShape + 0.08 : currentShape - 0.3
                        if currentShape > 1 {
                            self.shapeResuve = false
                        } else if currentShape < 0.1 {
                            self.shapeResuve = true
                        }
                    }
                }
            }
    }
}

#Preview {
    LoadingView()
}
