//
//  HomeCoordinator.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//
import UIKit

final class HomeCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    let dependencies: DIContainer
    
    init(navigationController: UINavigationController, dependencies: DIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewModel = dependencies.makeHomeViewModel()
        let homeVC = HomeViewController(viewModel: viewModel)
        
        navigationController.pushViewController(homeVC, animated: true)
    }

}
