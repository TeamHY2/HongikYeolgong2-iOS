//
//  FriendsRankingCell.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/13/25.
//

import SwiftUI

struct FriendsRankingCell: View {
    var body: some View {
        HStack(spacing: 6.adjustToScreenWidth) {
            // 순위
            Text("12")
                .font(.suite(size: 14, weight: .medium), lineHeight: 32)
                .foregroundStyle(.gray100)
                .frame(width: 20)
            
            // 사용자명
            Text("사용자명")
                .font(.pretendard(size: 16, weight: .regular))
                .foregroundStyle(.gray100)
            
            Spacer()
            
            // 시간
            Text("시간")
                .font(.pretendard(size: 12, weight: .regular))
                .foregroundStyle(.gray100)
            
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 10)
        .background(.gray800)
        .cornerRadius(4)
    }
}

#Preview {
    FriendsRankingCell()
}
