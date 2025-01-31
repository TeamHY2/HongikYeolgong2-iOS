//
//  AuthCoordinator.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//
import UIKit

final class AuthCoordinator: Coordinator, LoginCoordinatorDelegate {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    let dependencies: DIContainer
    
    func start() {
        goToLogin()
    }
    
    init(navigationController: UINavigationController, dependencies: DIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func goToLogin() {
        let viewModel = dependencies.makeLoginViewModel()
        viewModel.coordinator = self
        let loginVC = LoginViewController(viewModel: viewModel)
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func goToSignUp() {
        let viewModel = dependencies.makeSignUpViewModel()
        viewModel.coordinator = self
        let signUpVC = SignUpViewController(viewModel: viewModel)
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    func goToHome() {
        let appCoordinator = parentCoordinator as! AppCoordinator
        appCoordinator.goToHome()
        childDidFinish(self)
    }
}
