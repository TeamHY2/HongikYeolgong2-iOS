//
//  AppCoordinator.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//
import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    private let appDiContainer: DIContainer
    
    // MARK: - Initializers
    
    init(navigationController: UINavigationController, appDiContainer: DIContainer) {
        self.navigationController = navigationController
        self.appDiContainer = appDiContainer
    }
    
    // MARK: - Methods
    
    func start() {
        goToSplash()        
    }
    
    func goToAuth() {
        children.removeAll()
        navigationController.viewControllers.removeAll()
        let authCoordinator = appDiContainer.makeAuthCoordinator(navigationController: navigationController)
                
        authCoordinator.parentCoordinator = self
                
        children.append(authCoordinator)
        authCoordinator.start()
    }
    
    func goToHome() {
        children.removeAll()
        let coordinator = appDiContainer.makeMainTabCoordinator(navigationController: navigationController)
        
        coordinator.parentCoordinator = self
        children.append(coordinator)
        navigationController.viewControllers.removeAll()
        coordinator.start()
    }
    
    // Splash에서 로그인 상태를 확인한다.
    func goToSplash() {
        children.removeAll()
        let splashCoordinator = appDiContainer.makeSplashCoordinator(navigationController: navigationController)
        splashCoordinator.parentCoordinator = self
        children.append(splashCoordinator)
        splashCoordinator.start()
    }
}
