//
//  Skeleton.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/29/24.
//

import SwiftUI

struct Skeleton: View {
    @State var opacity: Double = 0.2
    @State var isAnimating: Bool = false
    let color: Color = .gray600
    let height: CGFloat
    
    var body: some View {
            RoundedRectangle(cornerRadius: 10.0)
            .fill(color.opacity(opacity))
            .frame(maxWidth: .infinity, minHeight: height)
            .onAppear {
                withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                    opacity = opacity >= 0.4 ? 0.2 : 0.4
                }
            }
    }
}
