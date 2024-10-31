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
                    .font(.pretendard(size: 24, weight: .bold), lineHeight: 30)
                    .foregroundColor(.gray100)
                
                Spacer()
                
                HStack(spacing: 7) {
                    Button(action: {
                        yearWeek -= 1
                    }, label: {
                        Image(.leftArrow)
                    })
                    .frame(width: 36, height: 36)
                    
                    Button(action: {
                        yearWeek += 1
                    }, label: {
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
        .onAppear {
            rankingDataInteractor.getCurrentWeekField(weekNumber: $yearWeek)
        }.onChange(of: yearWeek) {
            rankingDataInteractor.getWeeklyRanking(yearWeek: $0, weeklyRanking: $weeklyRanking)
        }
        .background(.dark)
    }
}
