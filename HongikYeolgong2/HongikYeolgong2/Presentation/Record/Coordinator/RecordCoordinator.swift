//
//  RecordCoordinator.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/31/25.
//
import UIKit

final class RecordCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    let dependencies: DIContainer
    
    init(navigationController: UINavigationController, dependencies: DIContainer) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        let viewModel = dependencies.makeRecordViewModel()
        let recordVC = RecordViewController()
        
        navigationController.pushViewController(recordVC, animated: true)
    }
    
    
}
