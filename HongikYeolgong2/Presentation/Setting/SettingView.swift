//
//  SettingView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/13/24.
//

import SwiftUI
import Combine

struct SettingView: View {
    @Environment(\.injected.appState) var appState
    @Environment(\.injected.interactors.userDataInteractor) var userDataInteractor
    @Environment(\.injected.interactors.userPermissionsInteractor) var userPermissionsInteractor
    
    @State private var userProfile: AppState.UserData = .init()
    @State private var isOnAlarm = UserDefaults.standard.bool(forKey: "isOnAlarm")
    @State private var settingPath: [Page] = []
    @State private var shouldShowWithdrawModal = false
    @State private var shouldShowLogoutModal = false
    
    var body: some View {    
        NavigationStack(path: $settingPath) {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 19.adjustToScreenWidth) {
                        ProfileImage()
                        
                        HStack(spacing: 8.adjustToScreenWidth) {
                            ProfileText(text: userProfile.nickname)
                                
                            
                            ProfileText(text: "|", textColor: Color.gray400)
                                
                            
                            ProfileText(text: userProfile.department)
                        }
                    }
                    
                    VStack(spacing: 20.adjustToScreenHeight) {
                        MenuItem(title: "공지사항") {
                            settingPath.append(.webView(title: "공지사항", url: SecretKeys.noticeUrl))
                        } content: {
                            Image(.arrowRight)
                        }
                        
                        MenuItem(title: "문의사항") {
                            settingPath.append(.webView(title: "문의사항", url: SecretKeys.qnaUrl))
                        } content: {
                            Image(.arrowRight)
                        }
                        
                        MenuItem(title: "열람실 종료 시간 알림") {}
                    content: {
                        Toggle("", isOn: Binding(
                            get: { isOnAlarm },
                            set: { _ in userPermissionsInteractor.handleNotificationPermissions() }
                        ))
                        .toggleStyle(SwitchToggleStyle(tint: Color.blue100))
                        .fixedSize()
                        .padding(.trailing, 3)
                    }
                    }
                    .padding(.top, 20.adjustToScreenHeight)
                    
                    InfomationView()
                        .padding(.top, 10.adjustToScreenHeight)
                }
                .padding(.top, 32.adjustToScreenHeight)
                
                Spacer()
                
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                        shouldShowLogoutModal.toggle()
                    } label: {
                        ProfileText(text: "로그아웃", textColor: Color.gray300)
                    }
                    
                    ProfileText(text: "|", textColor: Color.gray400)
                        .padding(.horizontal, 24.adjustToScreenWidth)
                    
                    Button {
                        shouldShowWithdrawModal.toggle()
                    } label: {
                        ProfileText(text: "회원탈퇴", textColor: Color.gray300)
                    }
                    Spacer()
                }
                .padding(.bottom, 36.adjustToScreenHeight)
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
            .modifier(IOSBackground())
            .systemOverlay(isPresented: $shouldShowWithdrawModal) {
                ModalView(isPresented: $shouldShowWithdrawModal,
                          title: "정말 탈퇴하실 건가요?",
                          confirmButtonText: "돌아가기",
                          cancleButtonText: "탈퇴하기",
                          confirmAction: {},
                          cancleAction: { userDataInteractor.withdraw() })
            }
            .systemOverlay(isPresented: $shouldShowLogoutModal) {
                ModalView(isPresented: $shouldShowLogoutModal,
                          title: "로그아웃 하실 건가요",
                          confirmButtonText: "돌아가기",
                          cancleButtonText: "로그아웃하기",
                          confirmAction: {},
                          cancleAction: { userDataInteractor.logout() })
            }
            .onReceive(isOnAlarmUpdated) {
                isOnAlarm = $0
            }
            .onReceive(isSceneActive) {
                userPermissionsInteractor.resolveStatus(for: .localNotifications)
            }
            .onReceive(userProfileUpdated) {
                userProfile = $0
            }
            .navigationDestination(for: Page.self) { page in
                switch page {
                case let .webView(title, url):
                    WebViewWithNavigation(url: url, title: title)
                }
            }
        }
    }
}

// MARK: - Publishers
extension SettingView {
    var isOnAlarmUpdated: AnyPublisher<Bool, Never> {
        appState.updates(for: \.userData.isOnAlarm)
    }
    
    var isSceneActive: AnyPublisher<Void, Never> {
        appState.updates(for: \.system.scenePhase)
            .filter { $0 == .active }
            .map { _ in }
            .eraseToAnyPublisher()
    }
    
    var userProfileUpdated: AnyPublisher<AppState.UserData, Never> {
        appState.updates(for: \.userData)
    }
}

// MARK: - SubViews
struct ProfileText: View {
    let text: String
    var textColor: Color = .gray200
    
    var body: some View {
        Text(text)
            .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
            .foregroundStyle(textColor)
            .padding(.trailing, 8)
    }
}

struct ProfileImage: View {
    var body: some View {
        Image(.settingIcon)
            .resizable()
            .frame(width: 55.adjustToScreenWidth, height: 55.adjustToScreenHeight)
    }
}

struct InfomationView: View {
    var body: some View {
        HStack(spacing: 6.adjustToScreenWidth) {
            Image(.icInformation)
                .foregroundStyle(.gray300)
            
            Text("열람실 종료 10분, 30분 전에 알림을 보내 연장을 돕습니다.")
                .font(.pretendard(size: 12, weight: .regular),
                      lineHeight: 18.adjustToScreenHeight)
                .foregroundStyle(.gray300)
        }
    }
}
