//
//  RankingCell.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/4/24.
//

import SwiftUI

struct RankingCell: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                HStack(spacing: 14) {
                    Text("1")
                        .font(.pretendard(size: 16, weight: .regular))
                        .foregroundStyle(.gray100)
                    
                    Text("건축학부")
                        .font(.pretendard(size: 16, weight: .regular), lineHeight: 26)
                        .foregroundStyle(.gray100)
                }
                
                Spacer()
                
                HStack(spacing: 22) {
                    Text("120H")
                        .font(.pretendard(size: 12, weight: .regular))
                        .foregroundStyle(.gray100)
                    HStack(spacing: 7) {
                        Text("+1")
                            .font(.pretendard(size: 16, weight: .regular))
                            .foregroundStyle(.gray100)
                        Image(.polygonGray)
                    }
                }
            }
            .padding(EdgeInsets(top: 13, leading: 24, bottom: 13, trailing: 24))
        }
        .background(.gray800)
        .cornerRadius(8)        
    }
}

#Preview {
    RankingCell()
}
