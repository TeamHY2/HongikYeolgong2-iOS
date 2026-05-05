//
//  FriendNotificationView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/20/25.
//

import SwiftUI

struct FriendNotificationView: View {
    @Environment(\.injected.interactors.friendInteractor) var friendInteractor
    @Environment(\.injected.appState) var appState
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
                    ForEach(appState.value.notificationState.notificationList, id: \.self) { notification in
                        NotificationRequestCell(
                            name: notification.senderNickname,
                            time: notification.receivedAt,
                            deleteAction: {
                                deleteButtonAction(info: notification, isAccept: false)
                            },
                            acceptAction: {
                                deleteButtonAction(info: notification, isAccept: true)
                            }
                        )
                    }
                }
                .padding(.horizontal, 32.adjustToScreenWidth)
            }
            .refreshable {
                refreshAction()
                try? await Task.sleep(nanoseconds: 1_000_000_000)
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
    
    // 수락, 삭제 버튼 액션
    private func deleteButtonAction(info: Notification, isAccept: Bool) {
        //guard let info = notificationList.value else { return }
        friendInteractor.respondFriendRequest(info: info, isAccept: isAccept) { result in
            if result {
                refreshAction()
            }
        }
    }
    
    // 새로고침
    private func refreshAction() {
        friendInteractor.getNotificationList()
    }
}
