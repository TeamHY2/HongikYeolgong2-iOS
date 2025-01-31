//
//  MainTabCoordinator.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//

import UIKit

final class MainTabCoordinator: Coordinator {
    
    // MARK: - Properties
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    let dependencies: DIContainer
    
    // MARK: - Intializer
    init(navigationController: UINavigationController, dependencies: DIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    // MARK: - Method
    func start() {
        initializeHomeTabFlow()
    }
        
    // 탭바코디네이터 구성
    func initializeHomeTabFlow() {
        let tabBarVC = TabBarViewController()
        
        let homeNavigationController = UINavigationController()
        let recordNavigationController = UINavigationController()
        let rankingNavigationController = UINavigationController()
        let profileNavigationController = UINavigationController()
        
        let homeCoordinator = dependencies.makeHomeCoordinator(navigationController: homeNavigationController)
        let recordCoordinator = dependencies.makeRecordCoordinator(navigationController: recordNavigationController)
        let rankingCoordinator = dependencies.makeRankingCoordinator(navigationController: rankingNavigationController)
        let profileCoordinator = dependencies.makeProfileCoordinator(navigationController: profileNavigationController)
        
        // parentCoordinator를 AppCoordinator로 설정
        homeCoordinator.parentCoordinator = parentCoordinator
        recordCoordinator.parentCoordinator = parentCoordinator
        rankingCoordinator.parentCoordinator = parentCoordinator
        profileCoordinator.parentCoordinator = parentCoordinator
        
        tabBarVC.setViewControllers([homeNavigationController, recordNavigationController, rankingNavigationController, profileNavigationController])
        navigationController.pushViewController(tabBarVC, animated: true)
        
        parentCoordinator?.children.append(homeCoordinator)
        parentCoordinator?.children.append(recordCoordinator)
        parentCoordinator?.children.append(rankingCoordinator)
        parentCoordinator?.children.append(profileCoordinator)
        
        homeCoordinator.start()
        recordCoordinator.start()
        rankingCoordinator.start()
        profileCoordinator.start()
    }
}
