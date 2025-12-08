//
//  AppRouter.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/19/25.
//

import SwiftUI

final class AppRouter: ObservableObject {
    @Published var currentTab: Tab = .home
    @Published var path: [Route] = []
    
    // 화면 이동
    func push(to route: Route) {
        path.append(route)
    }
    
    // 뒤로 가기
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    // 루트로 가기
    func popToRoot() {
        path = []
    }
    
    // 탭 변경
    func switchTab(_ tab: Tab) {
        currentTab = tab
        popToRoot()
    }
}

// MARK: - 진입 view case 관리
enum Route: Hashable {
    // 전역
    case webView(title: String, url: String)
    
    // 온보딩
    case signUp
    
    // 친구 탭
    case friendNotification(notificationList: [Notification])
    case friendSearch
    
    // 설정 탭
    case profile(nickname: String, department: String)
}

// MARK: - 뷰 진입 로직 관리
extension View {
    /// 앱 내 모든 View 진입 로직 관리
    func withAppDestinations() -> some View {
        self.navigationDestination(for: Route.self) { route in
            Group {
                switch route {
                    case let .webView(title, url):
                        WebViewWithNavigation(url: url, title: title)
                        
                    case .signUp:
                        ProfileEditView()
                        
                    case let .friendNotification(notificationList):
                        FriendNotificationView(notificationList: notificationList)
                    case .friendSearch:
                        SearchFriendsView()
                        
                    case let .profile(nickname, department):
                        ProfileEditView(nickname: nickname, department: department)
                }
            }
            // 전체 view 커스텀 navigationBar 사용
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

// toolbar -> Hidden 상태 뒤로가기 제스쳐 활성화
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
