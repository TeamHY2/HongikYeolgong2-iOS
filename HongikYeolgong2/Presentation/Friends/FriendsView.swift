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

struct FriendsView: View {
    @Environment(\.injected.interactors.friendInteractor) var friendInteractor
    @EnvironmentObject var router: AppRouter
    @Namespace private var rankTypeAnimation
    @State private var rankType: RankingType = .month
    @State private var friendTimeList: Loadable<[FriendStudyTime]> = .notRequest
    @State private var notificationList: Loadable<[Notification]> = .notRequest
    
    // 친구 비어있음 확인용
    private var friendListEmpty: Bool {
        switch friendTimeList {
            case let .success(value):
                if value.isEmpty { return true } else { return false }
            default: return true
        }}
    
    var body: some View {
        NetworkStateView(
            loadables: [AnyLoadable($friendTimeList), AnyLoadable($notificationList)],
            retryAction: getFriendsTimeList
        ) {
            content
        }
    }
    
    var content: some View {
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
                if let value = friendTimeList.value, !friendListEmpty {
                    Spacer().frame(height: 23.adjustToScreenHeight)
                    ScrollView {
                        VStack(spacing: 15.adjustToScreenHeight) {
                            ForEach(Array(value.enumerated()), id: \.offset){ index, info in
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
                            .font(.pretendard(size: 16, weight: .semibold), lineHeight: 26)
                            .foregroundStyle(.gray200)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.bottom, 80.adjustToScreenHeight)
                }
                
                Spacer()
            }
            .padding(.top, 33.adjustToScreenHeight)
            
            // 친구 랭킹 리스트 흐림 효과
            if !friendListEmpty {
                LinearGradient(
                    colors: [Color(red: 12/255, green: 13/255, blue: 17/255, opacity: 0),
                             Color(red: 12/255, green: 13/255, blue: 17/255, opacity: 1)],
                    startPoint: .center,
                    endPoint: .bottom)
                .ignoresSafeArea()
                .allowsHitTesting(false)
            }
            
            
            VStack{
                Spacer()
                
                Button {
                    friendAddButtonTapped()
                } label: {
                    HStack(spacing: 6.adjustToScreenWidth){
                        Image(.userPlus)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22.adjustToScreenWidth,
                                   height: 22.adjustToScreenHeight)
                        Text("친구 추가하기")
                            .font(.suite(size: 16, weight: .semibold))
                            .foregroundStyle(.gray100)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 52.adjustToScreenHeight)
                    .background(.gray800)
                    .cornerRadius(4)
                }
                .padding(.horizontal, 32.adjustToScreenWidth)
                .padding(.bottom, 36.adjustToScreenHeight)
            }
        }
        .modifier(IOSBackground())
        .onAppear{
            getFriendsTimeList()
            getNotificationList()
        }
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
            if let value = notificationList.value, !value.isEmpty {
                Image(.bellOn)
            } else {
                Image(.bellOff)
            }
        }
    }
}

// MARK:- Action
extension FriendsView {
    private func notificationButtonTapped() {
        guard let notificationList = notificationList.value else { return }
        router.push(to: .friendNotification(notificationList: notificationList))
    }
    
    private func friendAddButtonTapped() {
        router.push(to: .friendSearch)
    }
    
    // 랭킹 리스트 요청
    private func getFriendsTimeList() {
        friendInteractor.getFriendsTimeList(serchUsers: $friendTimeList, dateType: rankType)
    }
    
    private func getNotificationList() {
        friendInteractor.getNotificationList(notificationList: $notificationList)
    }
}

#Preview {
    FriendsView().environmentObject(AppRouter())
}
