//
//  FriendRequestCell.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/17/25.
//

import SwiftUI

struct FriendRequestCell: View {
    var user: SearchUser
    var addAction: () -> Void
    var calcelAction: () -> Void
    
    var body: some View {
        HStack{
            // 사용자 이름
            Text(user.nickname)
                .font(.pretendard(size: 16, weight: .regular))
                .foregroundStyle(.gray100)
            
            Spacer()
            
            // 친구 신청 버튼
            switch user.friendStatus {
                case .pending:
                    Button {
                        // 친구 신청 요청 api ation 추가
                        calcelAction()
                    } label: {
                        Text("친구요청됨")
                            .font(.pretendard(size: 14, weight: .regular))
                            .foregroundStyle(.gray200)
                            .frame(width: 80, height: 32)
                            .background(.gray400)
                            .cornerRadius(4)
                    }
                case .accepted:
                    Text("친구")
                        .font(.pretendard(size: 14, weight: .regular))
                        .foregroundStyle(.gray200)
                        .frame(width: 80, height: 32)
                        .background(.gray400)
                        .cornerRadius(4)
                case .rejected, .none:
                    Button {
                        // 친구 신청 요청 api ation 추가
                        addAction()
                    } label: {
                        Text("친구요청")
                            .font(.pretendard(size: 14, weight: .regular))
                            .foregroundStyle(.white)
                            .frame(width: 80, height: 32)
                            .background(.blue100)
                            .cornerRadius(4)
                    }
                case .loading:
                    Text("요청중...")
                        .font(.pretendard(size: 14, weight: .regular))
                        .foregroundStyle(.gray200)
                        .frame(width: 80, height: 32)
                        .background(.gray400)
                        .cornerRadius(4)
                    
            }
        }
    }
}
