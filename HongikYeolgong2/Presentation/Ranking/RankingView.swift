//
//  RankingView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct RankingView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("9월 2주차")
                    .font(.pretendard(size: 24, weight: .bold), lineHeight: 30)
                    .foregroundColor(.gray100)
                
                Spacer()
                
                HStack(spacing: 7) {
                    Button(action: {}, label: {
                        Image(.leftArrow)
                    })
                    .frame(width: 36, height: 36)
                    
                    Button(action: {}, label: {
                        Image(.rightArrow)
                    })
                    .frame(width: 36, height: 36)
                }
            }
            .padding(EdgeInsets(top: 33,
                                leading: 32,
                                bottom: 17,
                                trailing: 32))
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(1...20, id: \.self) { number in
                        RankingCell(currentRanking: number)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 100)
            }
        }
        .background(.dark)
    }
}
