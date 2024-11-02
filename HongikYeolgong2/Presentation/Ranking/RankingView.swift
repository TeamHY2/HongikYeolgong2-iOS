//
//  RankingView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct RankingView: View {
    @Environment(\.injected.interactors.rankingDataInteractor) var rankingDataInteractor
    @State private var yearWeek = 0
    @State private var weeklyRanking: WeeklyRanking = WeeklyRanking()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(weeklyRanking.weekName)
                    .font(.pretendard(size: 24, weight: .bold), lineHeight: 30.adjustToScreenHeight)
                    .foregroundColor(.gray100)
                
                Spacer()
                
                HStack(spacing: 7.adjustToScreenWidth) {
                    Button(action: {
                        yearWeek -= 1
                    }, label: {
                        Image(.leftArrow)
                    })
                    .frame(width: 36.adjustToScreenWidth, height: 36.adjustToScreenHeight)
                    
                    Button(action: {
                        yearWeek += 1
                    }, label: {
                        Image(.rightArrow)
                    })
                    .frame(width: 36.adjustToScreenWidth, height: 36.adjustToScreenHeight)
                }
            }
            .padding(EdgeInsets(top: 33.adjustToScreenHeight,
                                leading: 32.adjustToScreenWidth,
                                bottom: 17.adjustToScreenHeight,
                                trailing: 32.adjustToScreenWidth))
            
            RankingListView(departmentRankings: weeklyRanking.departmentRankings)
        }
        .onAppear {
            rankingDataInteractor.getCurrentWeekField(yearWeek: $yearWeek)
        }.onChange(of: yearWeek) {
            rankingDataInteractor.getWeeklyRanking(yearWeek: $0, weeklyRanking: $weeklyRanking)
        }
        .background(.dark)
    }
}
