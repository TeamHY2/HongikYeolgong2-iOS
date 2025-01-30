//
//  AppFlowCoordinator.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//
import UIKit

final class AppFlowCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    func start() {
        goToHome()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToAuth() {
        children.removeAll()
        
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.parentCoordinator = self
        children.append(authCoordinator)
        authCoordinator.start()
    }
    
    func goToHome() {
        children.removeAll()
        let coordinator = MainTabCoordinator(navigationController: navigationController)
        
        coordinator.parentCoordinator = self
        children.append(coordinator)
        coordinator.start()
    }
}
