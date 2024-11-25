//
//  HongikYeolgong2App.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI
import AmplitudeSwift

@main
struct HongikYeolgong2App: App {
    let enviroment = AppEnviroment.bootstrap()
    
    var body: some Scene {
        WindowGroup {
            let container: DIContainer = enviroment.container
            
            RootView()
                .inject(container)
        }
    }
}

extension Amplitude {
    static var instance = Amplitude(
        configuration: Configuration(
            apiKey: SecretKeys.ampliKey,
            autocapture: [.sessions, .appLifecycles, .screenViews]
        )
    )
}
