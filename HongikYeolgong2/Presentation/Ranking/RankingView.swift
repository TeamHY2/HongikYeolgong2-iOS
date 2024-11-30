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
        Group {
            switch loadable {
            case let .success(weeklyRanking):
                VStack {
                    HStack(spacing: 0) {
                        Text(weeklyRanking.weekName)
                            .font(.suite(size: 24, weight: .bold), lineHeight: 30.adjustToScreenHeight)
                            .foregroundColor(.gray100)
                        
                        Spacer()
                        
                        HStack(spacing: 7.adjustToScreenWidth) {
                            Button(action: {
                                getPreviosWeeklyRanking()
                            }, label: {
                                Image(.icCalendarLeft)
                            })
                            .frame(width: 36.adjustToScreenWidth, height: 36.adjustToScreenHeight)
                            
                            Button(action: {
                                getNextWeeklyRanking()
                            }, label: {
                                Image(.icCalendarRight)
                            })
                            .frame(width: 36.adjustToScreenWidth, height: 36.adjustToScreenHeight)
                        }
                    }
                    .padding(EdgeInsets(top: 32.adjustToScreenHeight,
                                        leading: 32.adjustToScreenWidth,
                                        bottom: 17.adjustToScreenHeight,
                                        trailing: 32.adjustToScreenWidth))
                    
                    RankingListView(departmentRankings: weeklyRanking.departmentRankings)
                }
            default:
                LoadingView()
            }
        }        
        .onAppear {
            getCurrentWeeklyRanking()
        }
        .onReceive(loadCompleted) { value in
            loadable.setSuccess(value: value)
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
            .delay(for: 0.5, scheduler: RunLoop.main)
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
