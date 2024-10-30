//
//  SystemEventHandler.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/30/24.
//

import Combine
import UIKit

protocol SystemEventHandler {}

struct RealSystemEventHandler: SystemEventHandler {
    let container: DIContainer
    private let cancelBag = CancelBag()
    
    init(container: DIContainer) {
        self.container = container
        
        installKeyboardVisibilityObserver()
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
}
