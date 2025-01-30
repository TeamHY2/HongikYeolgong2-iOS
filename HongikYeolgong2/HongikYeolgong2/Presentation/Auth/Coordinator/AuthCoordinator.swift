//
//  AuthCoordinator.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//
import UIKit

final class AuthCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    let dependencies: AppFlowCoordinatorDependencies
    
    func start() {
        goToLogin()
    }
    
    init(navigationController: UINavigationController, dependencies: AppFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func goToLogin() {
        let loginVC = LoginViewController()        
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func goToSignUp() {
        
    }
}
