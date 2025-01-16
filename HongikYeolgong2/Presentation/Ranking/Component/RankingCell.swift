//
//  RankingCell.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/4/24.
//

import SwiftUI

struct RankingCell: View {
    let departmentRankInfo: RankingDepartment
    let offset: Int
    
    var isStudyTimeLessThanZero: Bool {
        departmentRankInfo.studyDurationOfWeek <= 0
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                HStack(spacing: 14.adjustToScreenWidth) {
                    Text(isStudyTimeLessThanZero ? "-" : "\(departmentRankInfo.currentRank)")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(setFontColor)
                    
                    Text(departmentRankInfo.department)
                        .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                        .foregroundStyle(setFontColor)
                        .lineLimit(1)
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    Text("\(departmentRankInfo.studyDurationOfWeek)H")
                        .font(.pretendard(size: 12, weight: .regular))
                        .foregroundStyle(setFontColor)
                    
                    
                    HStack {
                        Text(rankChangeText)
                            .font(.pretendard(size: 12, weight: .regular))
                            .foregroundStyle(setFontColor)
                            .frame(maxWidth: 40, alignment: .trailing)
                        
                        rankImage
                    }
                }
            }
            .padding(.vertical, 13.adjustToScreenHeight)
            .padding(.horizontal, 24.adjustToScreenWidth)
        }
        .background(setBackground)
    }
}

extension RankingCell {
    private var rankChangeText: String {
        departmentRankInfo.rankChange > 0 ? "+\(departmentRankInfo.rankChange)" : "\(departmentRankInfo.rankChange)"
    }
    
    private var setBackground: some View {
        switch offset {
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
        switch offset {
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
    
    private var rankImage: some View {
        switch (departmentRankInfo.rankChange, departmentRankInfo.currentRank) {
        case let (rankChange, currentRank) where rankChange < 0 && currentRank == 2:
            Image(.rankDownSecond)
        case let (rankChange, currentRank) where rankChange > 0 && currentRank == 1:
            Image(.rankUpGray)
        case let (rankChange, _) where rankChange > 0:
            Image(.rankUp)
        case let (rankChange, _) where rankChange < 0:
            Image(.rankDown)
        default:
            Image(.rankNoChange)
        }
    }
}
