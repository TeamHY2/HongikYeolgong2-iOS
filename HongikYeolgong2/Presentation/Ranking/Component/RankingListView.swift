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
                ForEach(departmentRankings, id: \.self) { rankingInfo in
                    RankingCell(departmentRankInfo: rankingInfo)
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
