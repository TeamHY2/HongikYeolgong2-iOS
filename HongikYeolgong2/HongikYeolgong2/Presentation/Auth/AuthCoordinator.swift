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
    
    func start() {
        goToLogin()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func goToLogin() {        
        let loginVC = LoginViewController()
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func goToSignUp() {
        
    }
}
