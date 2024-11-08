//
//  SystemEventHandler.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/30/24.
//

import SwiftUI
import Combine
import UIKit

protocol SystemEventHandler {}

struct RealSystemEventHandler: SystemEventHandler {
    let container: DIContainer
    private let cancelBag = CancelBag()
    
    init(container: DIContainer) {
        self.container = container
        
        installKeyboardVisibilityObserver()
        installScenePhaseObserver()
    }
    
    private func installKeyboardVisibilityObserver() {
        let appState = container.appState
        
        Publishers.Merge(NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillShowNotification)
            .map { _ in true }, NotificationCenter.default
            .publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false })
        .sink {
            appState[\.system.isKeyboardActive] = $0
        }
        .store(in: cancelBag)
    }
    
    private func installScenePhaseObserver() {
        let appState = container.appState
        
        Publishers.Merge4(
            NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)
                .map { _ in ScenePhase.active }
            ,
            NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
                .map { _ in ScenePhase.inactive }
            ,
            NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
                .map { _ in ScenePhase.background }
            ,
            NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)
                .map { _ in ScenePhase.inactive }
                 
        )        
        .sink { appState[\.system.scenePhase] = $0 }
        .store(in: cancelBag)
    }
}
