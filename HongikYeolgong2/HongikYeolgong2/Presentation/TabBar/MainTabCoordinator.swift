//
//  MainTabCoordinator.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//

import UIKit

final class MainTabCoordinator: Coordinator {
    var parentCoordinator: Coordinator?    
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    let dependencies: DIContainer
    
    init(navigationController: UINavigationController, dependencies: DIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        initializeHomeTabFlow()
    }
    
    func initializeHomeTabFlow() {
        let tabBarVC = UITabBarController()
        
        let homeNavigationController = UINavigationController()
        let homeCoordinator = dependencies.makeHomeCoordinator(navigationController: homeNavigationController)
        
        homeCoordinator.parentCoordinator = parentCoordinator
        
        let homeItem = UITabBarItem()
        homeItem.image = UIImage(systemName: "house.fill")
        homeNavigationController.tabBarItem = homeItem
        
        tabBarVC.viewControllers = [homeNavigationController]
        navigationController.pushViewController(tabBarVC, animated: true)
        
        parentCoordinator?.children.append(homeCoordinator)
        
        homeCoordinator.start()
    }
}
