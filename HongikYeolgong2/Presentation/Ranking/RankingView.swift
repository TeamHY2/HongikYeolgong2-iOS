//
//  RankingView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import SwiftUI

struct RankingView: View {
    @StateObject private var rankingDataInteractor = RankingDataInteractorImpl(
            studySessionRepository: StudySessionRepositoryImpl(),
            weeklyRepository: WeeklyRepositoryImpl()
        )
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(rankingDataInteractor.weeklyRanking.weekName)
                    .font(.suite(size: 24, weight: .bold), lineHeight: 30.adjustToScreenHeight)
                    .foregroundColor(.gray100)
                
                Spacer()
                
                HStack(spacing: 7.adjustToScreenWidth) {
                    Button(action: {
                        rankingDataInteractor.changeWeek(by: -1)
                    }, label: {
                        Image(.icCalendarLeft)
                    })
                    .frame(width: 36.adjustToScreenWidth, height: 36.adjustToScreenHeight)
                    
                    Button(action: {
                        rankingDataInteractor.changeWeek(by: 1)
                    }, label: {
                        Image(rankingDataInteractor.isNextWeekAvailable() ? .icCalendarRight : .isCalendarRightDisabled)
                    })
                    .disabled(!rankingDataInteractor.isNextWeekAvailable())
                    .frame(width: 36.adjustToScreenWidth, height: 36.adjustToScreenHeight)
                }
            }            
            .padding(EdgeInsets(top: 32.adjustToScreenHeight,
                                leading: 32.adjustToScreenWidth,
                                bottom: 17.adjustToScreenHeight,
                                trailing: 32.adjustToScreenWidth))
            
            RankingListView(departmentRankings: rankingDataInteractor.weeklyRanking.departmentRankings)
        }
        .onAppear {
            getCurrentWeeklyRanking()
        }
        .modifier(IOSBackground())
    }
    
    func getCurrentWeeklyRanking() {
        rankingDataInteractor.getWeeklyRanking()
    }
}
