//
//  HongikYeolgong2App.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI
import AmplitudeSwift
import ComposableArchitecture

@main
struct HongikYeolgong2App: App {
    
    var body: some Scene {
        WindowGroup {
            SwiftUIView(store: .init(initialState: AppFeature.State(), reducer: {
                AppFeature()
            }))
        }
    }
}
