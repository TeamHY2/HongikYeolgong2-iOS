//
//  AuthCoordinator.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/8/24.
//

import SwiftUI

protocol AuthCoordinatorType: Coordinator, ObservableObject {}

final class AuthCoordinator: AuthCoordinatorType {
    var paths: [Scene] = []
    
    enum Scene: Hashable {
        case loginOnboarding
        case signUp
    }
    
    @ViewBuilder
    func buildScreen(scene: Scene) -> some View {
        switch scene {
        case .loginOnboarding:
            LoginView()
        case .signUp:
            SignUpView()
        }
    }
}
