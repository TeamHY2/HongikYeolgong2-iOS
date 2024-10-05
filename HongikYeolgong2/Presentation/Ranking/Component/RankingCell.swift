//
//  RankingCell.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/4/24.
//

import SwiftUI

struct RankingCell: View {
    let currentRanking: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                HStack(spacing: 14) {
                    Text("1")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(setFontColor)
                    
                    Text("건축학부")
                        .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                        .foregroundStyle(setFontColor)
                }
                
                Spacer()
                
                HStack(spacing: 22) {
                    Text("120H")
                        .font(.pretendard(size: 12, weight: .regular))
                        .foregroundStyle(setFontColor)
                    HStack(spacing: 7) {
                        Text("+1")
                            .font(.pretendard(size: 16, weight: .regular))
                            .foregroundStyle(setFontColor)
                        Image(.polygonGray)
                    }
                }
            }
            .padding(EdgeInsets(top: 13, leading: 24, bottom: 13, trailing: 24))
        }
        .background(setBackground)
        
    }
    
    private var setBackground: some View {
        switch currentRanking {
        case 1:
            return Image(.rankingBox1)
                .resizable()
                .frame(maxWidth: .infinity)
        case 2:
            return Image(.rankingBox2)
                .resizable()
                .frame(maxWidth: .infinity)
        case 3:
            return Image(.rankingBox3)
                .resizable()
                .frame(maxWidth: .infinity)
        default:
            return Image(.rankingBoxDefault)
                .resizable()
                .frame(maxWidth: .infinity)
        }
    }
    
    private var setFontColor: Color {
        switch currentRanking {
        case 1:
                .gray600
        case 2:
                .white
        case 3:
                .gray100
        default:
                .gray100
        }
    }
}
