//
//  SplashCoordinator.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//

import UIKit

final class SplashCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    let dependencies: DIContainer
    
    init(navigationController: UINavigationController, dependencies: DIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewModel = dependencies.makeSplashViewModel()
        viewModel.coordinator = self
        let splashVC = SplashViewController(viewModel: viewModel)
        
        navigationController.pushViewController(splashVC, animated: true)
    }
}

extension SplashCoordinator: SplashCoordinatorDelegate {
    func goToAuth() {
        let appCoordinator = parentCoordinator as! AppCoordinator
        
        appCoordinator.goToAuth()
        
        childDidFinish(self)
    }
    
    func goToHome() {
        let appCoordinator = parentCoordinator as! AppCoordinator
        appCoordinator.goToHome()
        
        childDidFinish(self)
    }
}




