//
//  FriendRequestCell.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/17/25.
//

import SwiftUI

struct FriendRequestCell: View {
    var body: some View {
        HStack{
            // 사용자 이름
            Text("사용자 이름")
                .font(.pretendard(size: 16, weight: .regular))
                .foregroundStyle(.gray100)
            
            Spacer()
            
            if true {
                // 친구 신청 버튼
                Button {
                    // 친구 신청 요청 api ation 추가
                } label: {
                    Text("친구요청")
                        .font(.pretendard(size: 14, weight: .regular))
                        .foregroundStyle(.white)
                        .frame(width: 80, height: 32)
                        .background(.blue100)
                        .cornerRadius(4)
                }
            } else {
                // 친구 신청 된 경우
                Text("친구요청됨")
                    .font(.pretendard(size: 14, weight: .regular))
                    .foregroundStyle(.gray200)
                    .frame(width: 80, height: 32)
                    .background(.gray400)
                    .cornerRadius(4)
            }
        }
    }
}

#Preview {
    FriendRequestCell()
}
