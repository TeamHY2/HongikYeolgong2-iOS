//
//  LocalNotificationService.swift
//  HongikYeolgong2-iOS
//
//  Created by 석기권 on 7/25/24.
//

import Foundation
import UserNotifications

class LocalNotificationService {
    
    static let shared = LocalNotificationService()
    
    private init() {}
    
    func requestPermission() {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted == true && error == nil {
                    #if DEBUG
                    print("Notification permission granted!")
                    #endif
                }
            }
    }
    
    func addNotification(interval: TimeInterval) {
        let noti1 = UNMutableNotificationContent()
        let noti2 = UNMutableNotificationContent()
        
        noti1.body = "열람실 시간 종료 30분 전이에요. 지금부터 열람실 연장이 가능해요!"
        noti1.sound = .default
        
        noti2.body = "열람실 시간 종료 10분 전이에요. 열람실 연장이 필요하다면 서둘러주세요!"
        noti2.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval - Constants.StudyRoomService.firstNotificationTime, repeats: false)
        let trigger2 = UNTimeIntervalNotificationTrigger(timeInterval: interval - Constants.StudyRoomService.secondNotificationTime, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: noti1, trigger: trigger)
        let request2 = UNNotificationRequest(identifier: UUID().uuidString, content: noti2, trigger: trigger2)
        
        UNUserNotificationCenter.current().add(request)
        UNUserNotificationCenter.current().add(request2)
    }
    
    func removeNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
