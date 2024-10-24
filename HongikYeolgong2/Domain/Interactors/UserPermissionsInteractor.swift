//
//  UserPermissionsInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation
import UserNotifications

enum Permission {
    case localNotifications
}

extension Permission {
    enum Status: Equatable {
        /// 아직 확인되지 않은 상태
        case unknown
        
        /// 사용자에게 권한을 요청하기 전 상태
        case notRequested
        
        /// 사용자가 권한을 승인한 상태
        case granted
        
        ///  사용자가 권한을 거부함 -> 앱설정 이동
        case denied
    }
}

protocol UserPermissionsInteractor: AnyObject {
    func resolveStatus(for permission: Permission)
    func request(permission: Permission)
}

final class RealUserPermissionsInteractor: UserPermissionsInteractor {
    private let appState: Store<AppState>
    private let openAppSetting: () -> Void
    
    init(appState: Store<AppState>, openAppSetting: @escaping () -> Void) {
        self.appState = appState
        self.openAppSetting = openAppSetting
    }
    
    ///  특정 권한 상태를 확인하고 앱 상태를 업데이트 합니다.
    /// - Parameter permission: 확인할 권한 종류
    func resolveStatus(for permission: Permission) {
        let keyPath = AppState.permissionKeyPath(for: .localNotifications)
        let currentStatus = appState[keyPath]
        guard currentStatus == .unknown else { return }
        let onResolve: (Permission.Status) -> Void = { [weak appState] status in
            appState?[keyPath] = status
        }
        switch permission {
        case .localNotifications:
            localNotificationsPermissionStatus(onResolve)
        }
    }
    
    /// 유저에게 권한을 요청합니다.
    /// - Parameter permission: 확인할 권한 종류
    func request(permission: Permission) {
        let keyPath = AppState.permissionKeyPath(for: .localNotifications)
        let currentStatus = appState[keyPath]
        guard currentStatus != .denied else {
            openAppSetting()
            return
        }
        switch permission {
        case .localNotifications:
            requestLocalNotificationsPermission()
        }
    }
}

extension UNAuthorizationStatus {
    var map: Permission.Status {
        switch self {
        case .denied: return .denied
        case .authorized: return .granted
        case .notDetermined, .provisional, .ephemeral: return .notRequested
        @unknown default: return .notRequested
        }
    }
}

private extension RealUserPermissionsInteractor {
    /// 실제 LocalNotification 권한의 상태를 체크하고 앱상태를 업데이트
    /// - Parameter resolve: 권한확인 결과를 반환받을 클로저
    func localNotificationsPermissionStatus(_ resolve: @escaping (Permission.Status) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                resolve(settings.authorizationStatus.map)
            }
        }
    }
    
    /// LocalNotification 권한을 요청하고 앱상태를 업데이트
    func requestLocalNotificationsPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (isGranted, error) in
            DispatchQueue.main.async {
                self.appState[\.permissions.push] = isGranted ? .granted : .denied
            }
        }
    }
}
