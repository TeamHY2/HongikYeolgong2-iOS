//
//  SettingView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/13/24.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.injected.appState) var appState
    @Environment(\.injected.interactors.userDataInteractor) var userDataInteractor
    @Environment(\.injected.interactors.userPermissionsInteractor) var userPermissionsInteractor
    
    @State private var userProfile = UserProfile()
    @State private var isOnAlarm = UserDefaults.standard.bool(forKey: "isOnAlarm")
    @State private var shouldShowWithdrawModal = false
    @State private var shouldShowLogoutModal = false
    @State private var shouldShowNotice = false
    @State private var shouldShowQna = false
    @State private var isFirstAppear = true
    
    var body: some View {
        VStack(alignment:.leading, spacing: 0) {
            NavigationLink("",
                           destination: WebViewWithNavigation(url: SecretKeys.noticeUrl, title: "공지사항")
                .edgesIgnoringSafeArea(.bottom),
                           isActive: $shouldShowNotice)
            .frame(width: 0, height: 0)
            
            NavigationLink("",
                           destination: WebViewWithNavigation(url: SecretKeys.qnaUrl, title: "문의사항")
                .edgesIgnoringSafeArea(.bottom),
                           isActive: $shouldShowQna)
            .frame(width: 0, height: 0)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(spacing: 0) {
                    Image(.settingIcon)
                        .resizable()
                        .frame(width: 55.adjustToScreenWidth, height: 55.adjustToScreenHeight)
                        .padding(.trailing, 19)
                    
                    Text(userProfile.nickname)
                        .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                        .padding(.trailing, 8)
                        .foregroundStyle(.gray200)
                    Text("|")
                        .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                        .padding(.trailing, 8)
                        .foregroundStyle(.gray300)
                    Text(userProfile.department)
                        .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                        .foregroundStyle(.gray200)
                }
                .padding(.top, 32.adjustToScreenHeight)
                .padding(.bottom, 20.adjustToScreenHeight)
                
                MenuItem(title: "공지사항", onTap: {
                    shouldShowNotice.toggle()
                }, content: {
                    Image(.arrowRight)
                })
                .padding(.bottom, 20.adjustToScreenHeight)
                
                MenuItem(title: "문의사항", onTap: {
                    shouldShowQna.toggle()
                }, content: {
                    Image(.arrowRight)
                })
                .padding(.bottom, 20.adjustToScreenHeight)
                
                MenuItem(title: "열람실 종료 시간 알림",
                         content: {
                    Toggle("", isOn: Binding(get: {
                        isOnAlarm
                    }, set: { _ in
                        userPermissionsInteractor.handleNotificationPermissions()
                    }))
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue100))
                    .fixedSize()
                    .padding(.trailing, 3)
                })
                .padding(.bottom, 10.adjustToScreenHeight)
                
                HStack(spacing: 6.adjustToScreenWidth) {
                    Image(.icInformation)
                        .foregroundStyle(.gray300)
                    
                    Text("열람실 종료 10분, 30분 전에 알림을 보내 연장을 돕습니다.")
                        .font(.pretendard(size: 12, weight: .regular),
                              lineHeight: 18.adjustToScreenHeight)
                        .foregroundStyle(.gray300)
                }
            }
            
            Spacer()
            
            HStack(alignment: .center, spacing: 0) {
                Spacer()
                Button(action: {
                    shouldShowLogoutModal.toggle()
                }, label: {
                    Text("로그아웃")
                        .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                        .foregroundStyle(Color.gray300)
                })
                
                Text("|")
                    .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                    .foregroundStyle(Color.gray300)
                    .padding(.horizontal, 24.adjustToScreenWidth)
                
                Button(action: {
                    shouldShowWithdrawModal.toggle()
                }, label: {
                    Text("회원탈퇴")
                        .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                        .foregroundStyle(Color.gray300)
                })
                Spacer()
            }
            .padding(.bottom, 32.adjustToScreenHeight)
        }
        .systemOverlay(isPresented: $shouldShowWithdrawModal) {
            ModalView(isPresented: $shouldShowWithdrawModal,
                      title: "정말 탈퇴하실 건가요?",
                      confirmButtonText: "돌아가기",
                      cancleButtonText: "탈퇴하기",
                      confirmAction: {},
                      cancleAction: { userDataInteractor.withdraw() }
            )
        }
        .systemOverlay(isPresented: $shouldShowLogoutModal) {
            ModalView(isPresented: $shouldShowLogoutModal,
                      title: "로그아웃 하실 건가요",
                      confirmButtonText: "돌아가기",
                      cancleButtonText: "로그아웃하기",
                      confirmAction: {},
                      cancleAction: { userDataInteractor.logout() }
            )
        }
        .padding(.horizontal, 32.adjustToScreenWidth)
        .modifier(IOSBackground())
        .onAppear {
            userDataInteractor.getUserProfile(userProfile: $userProfile)
        }
        .onReceive(appState.updates(for: \.userData.isOnAlarm)) {
            isOnAlarm = $0
        }
        .onReceive(appState.updates(for: \.system.scenePhase).filter { $0 == .active }) { _ in
            userPermissionsInteractor.resolveStatus(for: .localNotifications)
        }
    }
}
