//
//  AppCoordinator.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/8/24.
//

import SwiftUI

protocol AppCoordinatorType: Coordinator, ObservableObject {}

final class AppCoordinator: AppCoordinatorType {
    
    enum Scene: Hashable {
        case home
        case menu
    }
    
    @Published var paths: [Scene] = []
    
    @ViewBuilder
    func buildScreen(scene: Scene) -> some View {
        switch scene {
        case .home:
            HomeView()
        case .menu:
            MenuView()
        }
    }
}
