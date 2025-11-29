//
//  FriendNotificationView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/20/25.
//

import SwiftUI

struct FriendNotificationView: View {
    @EnvironmentObject var router: AppRouter
    @State private var notificationList: Loadable<[Notification]>
    
    init(notificationList: [Notification]) {
        self.notificationList = .success(notificationList)
    }
    
    var body: some View {
        VStack {
            // 네비게이션바
            HStack (spacing: 0){
                Button {
                    backButtonAction()
                } label: {
                    Image(.icProfileLeft)
                }
                
                Text("친구 알림")
                    .font(.suite(size: 18, weight: .semibold))
                    .foregroundStyle(.gray100)
                
                Spacer()
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
            .frame(height: 52.adjustToScreenHeight)
            
            ScrollView {
                VStack(spacing: 16.adjustToScreenHeight){
                    if let value = notificationList.value {
                        ForEach(value, id: \.self) { notification in
                            NotificationRequestCell(
                                name: notification.senderNickname,
                                time: notification.receivedAt,
                                deleteAction: {
                                },
                                acceptAction: {
                                }
                            )
                        }
                    }
                }
                .padding(.horizontal, 32.adjustToScreenWidth)
            }
        }
        .modifier(IOSBackground())
    }
}


// MARK: - Action
extension FriendNotificationView{
    private func backButtonAction() {
        router.pop()
    }
    
    // 삭제 버튼 액션
    private func deleteButtonAction() {
        
    }
    
    // 수락 버튼
    private func acceptButtonAction() {
        
    }
}
