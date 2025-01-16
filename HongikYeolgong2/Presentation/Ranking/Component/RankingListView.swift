//
//  RankingListView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import SwiftUI

struct RankingListView: View {
    let departmentRankings: [RankingDepartment]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(spacing: 16) {
                ForEach(Array(departmentRankings.enumerated()), id: \.self.offset) { (offset, rankingInfo) in
                    RankingCell(departmentRankInfo: rankingInfo, offset: offset + 1)
                }
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
            .padding(.bottom, 60.adjustToScreenHeight)
        }
    }
}

#Preview {
    RankingListView(departmentRankings: [])
}
