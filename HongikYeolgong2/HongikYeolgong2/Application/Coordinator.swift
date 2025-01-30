//
//  Coordinator.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//
import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get set }
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

extension Coordinator {
    // 자식코디네이터에대한 참조를 제거
    func childDidFinish(_ coordinator: Coordinator) {
        for (index, child) in children.enumerated() {
            if child === coordinator {
                children.remove(at: index)
                break
            }
        }
    }
}
