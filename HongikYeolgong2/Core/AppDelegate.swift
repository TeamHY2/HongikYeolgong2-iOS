//
//  AppDelegate.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 3/16/25.
//

import SwiftUI
import Firebase
import FirebaseMessaging
import AmplitudeSwift

class AppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setupNotification(application: application)
        // 메세지 델리게이트
        Messaging.messaging().delegate = self
        if let notification = launchOptions?[.remoteNotification] as? [AnyHashable: Any] {
            Amplitude.instance.track(eventType: "Push Noti")
        }
        return true
    }
    
    // 원격 알림 등록
    private func setupNotification(application: UIApplication) {
        // 포그라운드 Notification 알림 설정
        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
          options: authOptions,
          completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()
    }
    
    // fcm 토큰 등록 되었을 때
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

// MARK: - UNUserNotificationCenterDelegate
// Notification 관련 설정
extension AppDelegate: UNUserNotificationCenterDelegate {
    // 앱 실행 중 Notification 표시
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.banner, .sound, .badge])
    }
    
    // 앱 실행 중 외
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        Amplitude.instance.track(eventType: "Push Noti")
        completionHandler()
    }
}
    
// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    // FCM 토큰 수신
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        updateFCMTokenNeeded(fcmToken: fcmToken)
    }
    
    // FCM 토큰 갱신 여부 판단
    func updateFCMTokenNeeded(fcmToken: String?) {
        let userDefaults = UserDefaults.standard
        let storedToken = userDefaults.string(forKey: "FCMToken")
        
        // 기존 등록된 토큰과 다른지 확인
        if storedToken != fcmToken {
            
            userDefaults.setValue(fcmToken, forKey: "FCMToken")
            // 업데이트 상태 저장
            userDefaults.setValue(true, forKey: "isFCMTokenUpdated")
        }
    }
}
