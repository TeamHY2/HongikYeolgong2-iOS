//
//  FriendsView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/13/25.
//

import SwiftUI

enum RankingType: String, CaseIterable {
    case month = "월간"
    case day = "일간"
    
    // api 타입 전송용
    var typeName: String {
        switch self {
            case .day: return "DAILY"
            case .month: return "MONTHLY"
        }
    }
}

// 알림창 상태 표시
enum NotificationStatus {
    case newNotification
    case none
}

struct FriendsView: View {
    @Environment(\.injected.interactors.friendInteractor) var friendInteractor
    @EnvironmentObject var router: AppRouter
    @Namespace private var rankTypeAnimation
    @State private var rankType: RankingType = .month
    @State private var friendTimeList: [FriendStudyTime] = []
    
    // 친구 비어있음 확인용
    private var friendListEmpty: Bool { friendTimeList.isEmpty }
    var notificationStatus: NotificationStatus = .none
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                HStack{
                    // 랭킹 타입
                    if !friendListEmpty {
                        rankTypeTap
                    }
                    
                    Spacer()
                    
                    // 알림 벨
                    notificationButton
                }
                .padding(.horizontal, 32.adjustToScreenWidth)
                
                // 순위 셀 부분
                if !friendListEmpty {
                    Spacer().frame(height: 23.adjustToScreenHeight)
                    ScrollView {
                        VStack(spacing: 15.adjustToScreenHeight) {
                            ForEach(Array(friendTimeList.enumerated()), id: \.offset){ index, info in
                                FriendsRankingCell(frendInfo: info, offset: index+1)
                            }
                            // 버튼 하단 공백용
                            Spacer()
                                .frame(height: 80)
                        }
                        .padding(.horizontal, 32.adjustToScreenWidth)
                    }
                } else {
                    Spacer()
                    VStack(spacing: 30){
                        Image(.friendsListEmpty)
                            .padding(.leading, 21)
                        
                        Text("친구를 추가해\n공부 현황을 살펴보세요")
                            .font(.pretendard(size: 18, weight: .semibold), lineHeight: 26)
                            .foregroundStyle(.gray200)
                            .multilineTextAlignment(.center)
                    }
                }
                
                Spacer()
            }
            .padding(.top, 33.adjustToScreenHeight)
            
            // 친구 랭킹 리스트 흐림 효과
            LinearGradient(
                colors: [Color(red: 12/255, green: 13/255, blue: 17/255, opacity: 0),
                         Color(red: 12/255, green: 13/255, blue: 17/255, opacity: 1)],
                startPoint: .center,
                endPoint: .bottom)
            .ignoresSafeArea()
            .allowsHitTesting(false)
            
            
            VStack{
                Spacer()
                // 친구추가 버튼
                BaseButton(
                    title: "친구 추가하기",
                    backgroundColor: .gray600,
                    foregroundColor: .gray100,
                    radius: 4,
                    action: { friendAddButtonTapped() }
                )
                .padding(.horizontal, 32.adjustToScreenWidth)
                .padding(.bottom, 36.adjustToScreenHeight)
            }
        }
        .modifier(IOSBackground())
        .onAppear{ getFriendsTimeList() }
        .onChange(of: rankType) { _ in
            getFriendsTimeList()
        }
    }
    
    var rankTypeTap: some View {
        HStack {
            ForEach(RankingType.allCases, id: \.self) { rank in
                Button {
                    rankType = rank
                } label: {
                    ZStack {
                        if rank == self.rankType {
                            RoundedRectangle(cornerRadius: 4, style: .continuous)
                                .fill(.blue100)
                                .frame(width: 49, height: 26)
                                .matchedGeometryEffect(id: "rankType", in: rankTypeAnimation)
                        } else {
                            RoundedRectangle(cornerRadius: 4, style: .continuous)
                                .fill(.clear)
                                .frame(width: 49, height: 26)
                        }
                        Text(rank.rawValue)
                            .font(.pretendard(size: 14, weight: .regular))
                            .foregroundStyle(rank == self.rankType ? Color.white : Color.gray100)
                            .frame(width: 49, height: 26)
                    }
                }
            }
        }
        .padding(3)
        .background(.gray800)
        .cornerRadius(6)
    }
    
    /// 알림 벨 표시
    var notificationButton: some View {
        Button {
            // 알림창 action 추가
            notificationButtonTapped()
        } label: {
            switch notificationStatus {
                case .newNotification:
                    Image(.bellOn)
                case .none:
                    Image(.bellOff)
            }
        }
    }
}

// MARK:- Action
extension FriendsView {
    private func notificationButtonTapped() {
        router.push(to: .friendNotification)
    }
    
    private func friendAddButtonTapped() {
        router.push(to: .friendSearch)
    }
    
    // 랭킹 리스트 요청
    private func getFriendsTimeList() {
        friendInteractor.getFriendsTimeList(serchUsers: $friendTimeList, dateType: rankType)
    }
}

#Preview {
    FriendsView().environmentObject(AppRouter())
}
