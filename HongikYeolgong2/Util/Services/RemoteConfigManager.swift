//
//  RemoteConfigManager.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/25/24.
//

import Foundation

import FirebaseRemoteConfig

struct RemoteConfigManager {
    static let shared = RemoteConfigManager()
    
    let remoteConfig = RemoteConfig.remoteConfig()
    let settings = RemoteConfigSettings()
    
    init() {
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
    }
    
    func getMinimumAppVersion() async -> Int? {
        do {
            try await remoteConfig.fetch()
            try await remoteConfig.activate()
            return remoteConfig["appVersion"].numberValue.intValue
        } catch {
            return nil
        }
    }
    
    func getPromotionData() async -> PromotionData? {
        do {
            try await remoteConfig.fetch()
            try await remoteConfig.activate()
            guard let promotionData = remoteConfig["promotionPopup"].stringValue.data(using: .utf8) else {
                return nil
            }
            let decoder = JSONDecoder()
            return try decoder.decode(PromotionData.self, from: promotionData)
        } catch {
            return nil
        }
    }
}


struct PromotionData: Decodable {
    let imageUrl: String
    let detailUrl: String
    let endDate: String
    let startDate: String
}
