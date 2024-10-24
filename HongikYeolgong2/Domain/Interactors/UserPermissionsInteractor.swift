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
        case unknown
        case notRequested
        case granted
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
    func localNotificationsPermissionStatus(_ resolve: @escaping (Permission.Status) -> Void) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                resolve(settings.authorizationStatus.map)
            }
        }
    }
    
    func requestLocalNotificationsPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (isGranted, error) in
            DispatchQueue.main.async {
                self.appState[\.permissions.push] = isGranted ? .granted : .denied
            }
        }
    }
}
