//
//  RemoteConfigManager.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/25/24.
//

import Foundation

import FirebaseRemoteConfig

class RemoteConfigManager {
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
}
