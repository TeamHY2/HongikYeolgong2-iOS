//
//  RankingListView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import SwiftUI

struct RankingListView: View {
    let departmentRankings: [RankingDepartment]
    @Environment(\.isRedacted) var isRedacted
    
    var body: some View {
        if isRedacted {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(departmentRankings, id: \.self) { rankingInfo in
                        RankingCell(departmentRankInfo: rankingInfo)
                            .redactedIfNeeded()
                    }
                }
                .padding(.horizontal, 32.adjustToScreenWidth)
                .padding(.bottom, 60.adjustToScreenHeight)
            }
            .scrollDisabled(true)
        } else {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 16) {
                    ForEach(departmentRankings, id: \.self) { rankingInfo in
                        RankingCell(departmentRankInfo: rankingInfo)
                            .redactedIfNeeded()
                    }
                }
                .padding(.horizontal, 32.adjustToScreenWidth)
                .padding(.bottom, 60.adjustToScreenHeight)
            }
        }
    }
}

#Preview {
    RankingListView(departmentRankings: [])
}
