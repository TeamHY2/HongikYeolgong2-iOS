//
//  RecordSkeletonView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/28/24.
//

import SwiftUI

struct RecordSkeletonView: View {
    @State var opacity: Double = 0.2
    var skeletonColor: Color = .gray600
    
    var body: some View {
        VStack(spacing: 0) {
            // 상단 시간 및 날짜
            HStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(skeletonColor.opacity(opacity))
                    .frame(width: 110.adjustToScreenWidth, height: 30.adjustToScreenHeight)
                
                Spacer()
            }
            
            Spacer().frame(height: 12.adjustToScreenHeight)
            
            // 요일
            HStack(alignment: .center) {
                ForEach(0..<7, id: \.self) { _ in
                    Spacer()
                    RoundedRectangle(cornerRadius: 5)
                        .fill(skeletonColor.opacity(opacity))
                        .frame(maxWidth: .infinity, maxHeight: 17)
                    Spacer()
                }
            }
            Spacer().frame(height: 8.adjustToScreenHeight)
            
            // 달력
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 5.adjustToScreenWidth), count: 7), spacing: 5.adjustToScreenHeight) {
                ForEach(0..<35, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: 8)
                        .fill(skeletonColor.opacity(opacity))
                        .frame(width: 40.adjustToScreenWidth,height: 33.adjustToScreenHeight)
                }
            }
            
            Spacer()
            
            // 하단 통계
            VStack(spacing: 13.adjustToScreenWidth) {
                ForEach(0..<2, id: \.self) { _ in
                    HStack(spacing: 13.adjustToScreenWidth){
                        RoundedRectangle(cornerRadius: 4)
                            .fill(skeletonColor.opacity(opacity))
                            .frame(maxWidth: .infinity, maxHeight: 88.adjustToScreenHeight)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(skeletonColor.opacity(opacity))
                            .frame(maxWidth: .infinity, maxHeight: 88.adjustToScreenHeight)
                    }
                }
            }
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .padding(.top, 32.adjustToScreenHeight)
        .padding(.bottom, 36.adjustToScreenHeight)
        .onAppear{
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                opacity = opacity >= 0.4 ? 0.2 : 0.4
            }
        }
    }
}


#Preview {
    RecordSkeletonView()
}
