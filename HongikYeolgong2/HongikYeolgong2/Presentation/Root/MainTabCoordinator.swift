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
    
    func start() {
        initializeHomeTabFlow()
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func initializeHomeTabFlow() {
        let tabBarVC = UITabBarController()
        
        let homeNavigationController = UINavigationController()
        let homeCoordinator = HomeFlowCoordinator(navigationController: homeNavigationController)
        
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
