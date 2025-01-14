//
//  SettingView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/13/24.
//

import SwiftUI
import Combine

import AmplitudeSwift

struct SettingView: View {
    @Environment(\.injected.appState) var appState
    @Environment(\.injected.interactors.userDataInteractor) var userDataInteractor
    @Environment(\.injected.interactors.userPermissionsInteractor) var userPermissionsInteractor
    
    @State private var isLoading: Loadable<Bool> = .success(true)
    @State private var userProfile: AppState.UserData = .init()
    @State private var isOnAlarm = UserDefaults.standard.bool(forKey: "isOnAlarm")
    @State private var settingPath: [Page] = []
    @State private var shouldShowWithdrawModal = false
    @State private var shouldShowLogoutModal = false
    
    var body: some View {
        NetworkStateView(
            loadables: [AnyLoadable($isLoading)],
            retryAction: retryAction
        ) {
            content
        }
    }
    
    var content: some View {
        NavigationStack(path: $settingPath) {
                VStack(alignment: .leading, spacing: 0) {
                    Spacer().frame(height: 32.adjustToScreenHeight)
                                     
                        VStack(alignment: .center, spacing: 0) {
                            ProfileImage()
                            Spacer().frame(height: 12.adjustToScreenHeight)
                            Text("\(userProfile.nickname)")
                                .font(.pretendard(size: 18, weight: .bold), lineHeight: 22.adjustToScreenHeight)
                                .foregroundColor(.gray100)
                            Text("\(userProfile.department)")
                                .font(.pretendard(size: 16, weight: .regular), lineHeight: 26.adjustToScreenHeight)
                                .foregroundColor(.gray100)
                            Spacer().frame(height: 8.adjustToScreenHeight)
                            Button(action: {
                                settingPath.append(.profile)
                            }, label: {
                                Text("프로필 변경")
                                    .font(.pretendard(size: 14, weight: .regular), lineHeight: 20.adjustToScreenHeight)
                                    .foregroundColor(.gray200)
                                    .padding(.vertical, 4)
                                    .padding(.horizontal, 8)
                            })
                            .background(.gray800)
                            .cornerRadius(4)
                        }.frame(maxWidth: .infinity)
                                        
                    Spacer().frame(height: 32.adjustToScreenHeight)
                    MenuItem(title: "공지사항",
                             onTap: navigateToNotice,
                             content: { Image(.arrowRight) })
                    
                    Spacer().frame(height: 20.adjustToScreenHeight)
                    MenuItem(title: "문의사항",
                             onTap: navigateToInquiry,
                             content: { Image(.arrowRight) })
                    
                    Spacer().frame(height: 20.adjustToScreenHeight)
                    MenuItem(title: "열람실 종료 시간 알림",
                             content: {  Toggle("", isOn: Binding(
                                get: { isOnAlarm },
                                set: { _ in userPermissionsInteractor.handleNotificationPermissions() }
                            ))
                            .toggleStyle(SwitchToggleStyle(tint: Color.blue100))
                            .fixedSize()
                            .padding(.trailing, 3) })
                    Spacer().frame(height: 10.adjustToScreenHeight)
                    
                    InfomationView()
                                
                Spacer()
                
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                        shouldShowLogoutModal.toggle()
                    } label: {
                        ProfileText(text: "로그아웃", textColor: Color.gray300)
                    }
                    Spacer().frame(width: 24.adjustToScreenWidth)
                    ProfileText(text: "|", textColor: Color.gray400)
                    Spacer().frame(width: 24.adjustToScreenWidth)
                    Button {
                        shouldShowWithdrawModal.toggle()
                    } label: {
                        ProfileText(text: "회원탈퇴", textColor: Color.gray300)
                    }
                    Spacer()
                }
              
                Spacer().frame(height: 36.adjustToScreenHeight)
            }
            .padding(.horizontal, 32.adjustToScreenWidth)
            .modifier(IOSBackground())
            .systemOverlay(isPresented: $shouldShowWithdrawModal) {
                ModalView(isPresented: $shouldShowWithdrawModal,
                          title: "정말 탈퇴하실 건가요?",
                          confirmButtonText: "돌아가기",
                          cancleButtonText: "탈퇴하기",
                          confirmAction: {},
                          cancleAction: withdrawButtonTapped)
            }
            .systemOverlay(isPresented: $shouldShowLogoutModal) {
                ModalView(isPresented: $shouldShowLogoutModal,
                          title: "로그아웃 하실 건가요",
                          confirmButtonText: "돌아가기",
                          cancleButtonText: "로그아웃하기",
                          confirmAction: {},
                          cancleAction: logoutButtonTapped)
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
                case .profile:
                    Text("hihi")
                default:
                    EmptyView()
                }
            }
        }
    }
}

// MARK: - Helpers
extension SettingView {
    func retryAction() {
        userDataInteractor.withdraw(isLoading: $isLoading)
    }
    
    func withdrawButtonTapped() {
        userDataInteractor.withdraw(isLoading: $isLoading)
        Amplitude.instance.track(eventType: "WithdrawButton")
    }
    
    func logoutButtonTapped() {
        userDataInteractor.logout()
        Amplitude.instance.track(eventType: "LogoutButton")
    }
    
    func navigateToNotice() {
        settingPath.append(.webView(title: "공지사항", url: SecretKeys.noticeUrl))
    }
    
    func navigateToInquiry() {
        settingPath.append(.webView(title: "문의사항", url: SecretKeys.qnaUrl))
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
    }
}

struct ProfileImage: View {
    var body: some View {
        Image(.settingIcon)
            .resizable()
            .frame(width: 60.adjustToScreenWidth, height: 60.adjustToScreenHeight)
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
