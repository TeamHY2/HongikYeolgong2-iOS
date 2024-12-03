//
//  RootView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import SwiftUI
import Combine

struct RootView: View {
    @Environment(\.injected.appState) var appState
    @Environment(\.injected.interactors.userDataInteractor) var userDataInteractor
    @Environment(\.injected.interactors.userPermissionsInteractor) var userPermissionsInteractor
    
    @State private var userSession: AppState.UserSession = .pending
    @State private var showAppUpdateModal = false
    @State private var isPromotionPresented = false
    
    var body: some View {
        Group {
            switch userSession {
            case .unauthenticated:
                OnboardingView()
            case .authenticated:
                MainTabView()
                    .onAppear {
                        userDataInteractor.getUserProfile()
                        checkPromotionPresent()
                    }
            case .pending:
                SplashView()
                    .ignoresSafeArea(.all)
                    .onAppear {
                        appVersionCheck()
                    }
            }
        }
        .systemOverlay(isPresented: $showAppUpdateModal, content: {
            ModalView(isPresented: $showAppUpdateModal,
                      type: .warning,
                      title: "원활한 서비스 이용을 위해 최신 버전으로\n업데이트가 필요합니다.",
                      confirmButtonText: "업데이트하기",
                      cancleButtonText: "종료하기",
                      confirmAction: { openAppStore() },
                      cancleAction: { exit(0) })
        })
        .systemOverlay(isPresented: $isPromotionPresented) {
            PromotionPopupView(isPromotionPopupPresented: $isPromotionPresented)
        }
        .onReceive(canRequestFirstPushPermissions) { _ in
            requestUserPushPermissions()
        }
        .onReceive(userSessionUpdated) {
            userSession = $0
        }
    }
}

private extension RootView {
    var userSessionUpdated: AnyPublisher<AppState.UserSession, Never> {
        appState.updates(for: \.userSession)
    }
    
    var canRequestFirstPushPermissions: AnyPublisher<Void, Never> {
        appState.updates(for: \.permissions.push)
            .filter { $0 == .notRequested }
            .map { _ in }
            .eraseToAnyPublisher()
    }
}

private extension RootView {
    func appVersionCheck() {
        Task {
            guard let currentVersionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
                  let currentVersion = Int(currentVersionString.split(separator: ".").joined()),
                  let minimumVersion = await RemoteConfigManager.shared.getMinimumAppVersion() else {
                return
            }
            
            guard currentVersion >= minimumVersion else {       
                showAppUpdateModal.toggle()
                return
            }
            
            userDataInteractor.checkAuthentication()
            userPermissionsInteractor.resolveStatus(for: .localNotifications)
        }
    }
    
    func openAppStore() {
        if let url = URL(string: "https://apps.apple.com/app/id/\(SecretKeys.appleID)") {
                    if UIApplication.shared.canOpenURL(url) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
    }
    
    func requestUserPushPermissions() {
        userPermissionsInteractor.request(permission: .localNotifications)
    }
    
    // PromotionPopupView 표시여부 체크
    func checkPromotionPresent() {
        let todayDate = Date().toDateString()
        
        // 오늘 보지 않기 날짜 체크
        if let dismissedDate = UserDefaults.standard.string(forKey: "dismissedTodayKey"),
           dismissedDate == todayDate {
            isPromotionPresented = false
            return
        } else {
            // 프로모션 표시 여부 확인 코드 추가
            // url 불러오는 과정 추가
            isPromotionPresented = true
            
        }
        
    }
}

#Preview {
    RootView()
}
