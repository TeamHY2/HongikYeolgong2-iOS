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
    // 랭킹 기준 날짜
    @State var baseDate: Date = Date()
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(weeklyRanking.weekName)
                    .font(.suite(size: 24, weight: .bold), lineHeight: 30.adjustToScreenHeight)
                    .foregroundColor(.gray100)
                
                Spacer()
                
                HStack(spacing: 7.adjustToScreenWidth) {
                    Button(action: {
                        changeWeek(by: -1) {
                            getWeeklyRanking()
                        }
                    }, label: {
                        Image(.icCalendarLeft)
                    })
                    .frame(width: 36.adjustToScreenWidth, height: 36.adjustToScreenHeight)
                    
                    Button(action: {
                        changeWeek(by: 1) {
                            getWeeklyRanking()
                        }
                    }, label: {
                        Image(isNextWeekAvailable() ? .isCalendarRightDisabled : .icCalendarRight)
                    })
                    .disabled(isNextWeekAvailable())
                    .frame(width: 36.adjustToScreenWidth, height: 36.adjustToScreenHeight)
                }
            }            
            .padding(EdgeInsets(top: 32.adjustToScreenHeight,
                                leading: 32.adjustToScreenWidth,
                                bottom: 17.adjustToScreenHeight,
                                trailing: 32.adjustToScreenWidth))
            
            RankingListView(departmentRankings: weeklyRanking.departmentRankings)
        }
        .onAppear {
            getWeeklyRanking()
        }
        .modifier(IOSBackground())
    }
    
    func getWeeklyRanking() {
        rankingDataInteractor.getWeeklyRanking(weeklyRanking: $weeklyRanking, baseDate: baseDate)
    }
    
    // 주차 변경
    func changeWeek(by offset: Int, completion: (() -> Void)) {
        var calendar = Calendar(identifier: .iso8601)
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul")!
        self.baseDate = calendar.date(byAdding: .weekOfYear, value: offset, to: baseDate) ?? baseDate
    }
    
    // 미래 주차 필터링
    func isNextWeekAvailable() -> Bool {
        let today = Date()
        return baseDate.formattedFullDate() == today.formattedFullDate()
    }
}
