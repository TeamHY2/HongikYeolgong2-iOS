//
//  FriendsView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/13/25.
//

import SwiftUI

enum RankingTypeEnum: String, CaseIterable {
    case month = "월간"
    case day = "일간"
}

// 알림창 상태 표시
enum NotificationStatus {
    case newNotification
    case none
}

struct FriendsView: View {
    @Namespace private var rankTypeAnimation
    @State private var rankType: RankingTypeEnum = .month
    var notificationStatus: NotificationStatus = .none
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                // 랭킹 타입
                rankTypeTap
                
                Spacer()
                
                // 알림 벨
                notificationButton
            }
            
            Spacer().frame(height: 23.adjustToScreenHeight)
            
            // 순위 셀 부분
            VStack(spacing: 15.adjustToScreenHeight) {
                FriendsRankingCell()
                FriendsRankingCell()
                FriendsRankingCell()
                FriendsRankingCell()
            }
            
            Spacer()
            
            // 친구추가 버튼
            BaseButton(
                title: "친구 추가하기",
                backgroundColor: .gray600,
                foregroundColor: .gray100,
                radius: 4,
                action: {
                    // 친구 추가 View 진입 추가
                }
            )
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .padding(.bottom, 36.adjustToScreenHeight)
        .padding(.top, 33.adjustToScreenHeight)
        .modifier(IOSBackground())
    }
    
    var rankTypeTap: some View {
        HStack {
            ForEach(RankingTypeEnum.allCases, id: \.self) { rank in
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

extension FriendsView {
//    private func tapAction() -> some View {
//        
//    }
}

#Preview {
    FriendsView()
}
