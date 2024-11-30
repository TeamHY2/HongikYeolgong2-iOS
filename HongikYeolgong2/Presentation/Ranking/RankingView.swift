//
//  RankingView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/23/24.
//

import Combine
import SwiftUI

struct RankingView: View {
    @Environment(\.injected.interactors.rankingDataInteractor) var rankingDataInteractor
    @State private var yearWeek = 0
    @State private var weeklyRanking = CurrentValueSubject<Loadable<WeeklyRanking>, Never>(.notRequest)
    @State private var loadable: Loadable<WeeklyRanking> = .notRequest
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                switch loadable {
                case let .success(weeklyRanking):
                    Text(weeklyRanking.weekName)
                        .font(.suite(size: 24, weight: .bold), lineHeight: 30.adjustToScreenHeight)
                        .foregroundColor(.gray100)
                default:
                    Text("11월 4주차")
                        .opacity(0)
                        .font(.suite(size: 24, weight: .bold), lineHeight: 30.adjustToScreenHeight)
                        .foregroundColor(.gray100)
                        .redactedIfNeeded()
                }
                
                Spacer()
                
                HStack(spacing: 7.adjustToScreenWidth) {
                    Button(action: {
                        getPreviosWeeklyRanking()
                    }, label: {
                        Image(.icCalendarLeft)
                    })
                    .frame(width: 36.adjustToScreenWidth, height: 36.adjustToScreenHeight)
                    .redactedIfNeeded()
                    
                    Button(action: {
                        getNextWeeklyRanking()
                    }, label: {
                        Image(.icCalendarRight)
                    })
                    .frame(width: 36.adjustToScreenWidth, height: 36.adjustToScreenHeight)
                    .redactedIfNeeded()
                }
            }
            .redacted(isRedacted: !loadable.isSuccess)
            .padding(EdgeInsets(top: 32.adjustToScreenHeight,
                                leading: 32.adjustToScreenWidth,
                                bottom: 17.adjustToScreenHeight,
                                trailing: 32.adjustToScreenWidth))
            
            switch loadable {
            case let .success(weeklyRanking):
                RankingListView(departmentRankings: weeklyRanking.departmentRankings)
            default:
                RankingListView(departmentRankings: .initialValue)
            }
        }
        .redacted(isRedacted: !loadable.isSuccess)
        .onAppear {
            getCurrentWeeklyRanking()
        }
        .onReceive(loadCompleted) { value in
            withAnimation {
                loadable.setSuccess(value: value)
            }
        }
        .onReceive(loadChangeed) { value in
            loadable.setSuccess(value: value)
        }
        .modifier(IOSBackground())
    }
    
    func getCurrentWeeklyRanking() {
        rankingDataInteractor.getCurrentWeeklyRanking(weeklyRanking: $weeklyRanking.value)
    }
    
    func getNextWeeklyRanking() {
        rankingDataInteractor.getNextWeeklyRanking(weeklyRanking: $weeklyRanking.value)
    }
    
    func getPreviosWeeklyRanking() {
        rankingDataInteractor.getPreviosWeeklyRanking(weeklyRanking: $weeklyRanking.value)
    }
}

extension RankingView {
    var loadCompleted: AnyPublisher<WeeklyRanking, Never> {
        weeklyRanking
            .filter { $0.isSuccess }
            .first()
            .map { $0.value }
            .replaceNil(with: .init())
            .delay(for: 2.0, scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    var loadChangeed:  AnyPublisher<WeeklyRanking, Never> {
        weeklyRanking
            .filter { $0.isSuccess }
            .map { $0.value }
            .replaceNil(with: .init())
            .dropFirst()
            .eraseToAnyPublisher()
    }
}
