//
//  NotificationRequestCell.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/20/25.
//

import SwiftUI

struct NotificationRequestCell: View {
    var name: String
    var time: String
    var deleteAction: () -> Void
    var acceptAction: () -> Void
    
    var body: some View {
        VStack{
            // 안내 텍스트
            HStack(alignment: .top) {
                Text(name + "님이 친구 요청을 보냈어요.")
                    .font(.pretendard(size: 16, weight: .regular), lineHeight: 26)
                    .foregroundStyle(.gray100)
                
                Spacer()
                Text(time)
                    .font(.pretendard(size: 12, weight: .regular), lineHeight: 18)
                    .foregroundStyle(.gray300)
            }
            
            // "삭제", "수락" 버튼
            HStack(spacing: 7.adjustToScreenHeight) {
                // 삭제 버튼
                Button {
                    deleteAction()
                } label: {
                    Text("삭제")
                        .font(.pretendard(size: 14, weight: .regular))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 34.adjustToScreenHeight)
                        .background(.gray400)
                        .cornerRadius(4)
                }
                
                // 수락 버튼
                Button {
                    acceptAction()
                } label: {
                    Text("수락")
                        .font(.pretendard(size: 14, weight: .regular))
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 34.adjustToScreenHeight)
                        .background(.blue100)
                        .cornerRadius(4)
                }
            }
        }
        .padding(.horizontal, 20.adjustToScreenWidth)
        .padding(.top, 16.adjustToScreenHeight)
        .padding(.bottom, 18.adjustToScreenHeight)
        .background(.gray800)
        .cornerRadius(4)
    }
}
