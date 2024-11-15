//
//  HongikYeolgong2App.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI

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
