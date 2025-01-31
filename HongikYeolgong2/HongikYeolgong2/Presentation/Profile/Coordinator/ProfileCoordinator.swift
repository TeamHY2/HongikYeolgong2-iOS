//
//  ProfileCoordinator.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/31/25.
//

import UIKit

final class ProfileCoordinator: Coordinator, ProfileCoordinatorDelegate {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    let dependencies: DIContainer
    
    init(navigationController: UINavigationController, dependencies: DIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewModel = dependencies.makeProfileViewModel()
        viewModel.coordinator = self
        let profileVC = ProfileViewController(viewModel: viewModel)
        navigationController.pushViewController(profileVC, animated: true)
    }
    
    func goToAuth() {
        let appCoordinator = parentCoordinator as! AppCoordinator
        appCoordinator.goToAuth()
        childDidFinish(self)
    }
}
