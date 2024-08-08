//
//  Coordinator.swift
//  HongikYeolgong2-iOS
//
//  Created by 권석기 on 8/8/24.
//

import SwiftUI

protocol Coordinator: AnyObject {
    associatedtype Scene: Hashable
    var paths: [Scene] { get set }
    
    func push(_ scene: Scene)
    func pop()
    func popToRoot()    
    
    associatedtype ViewType = View
    @ViewBuilder func buildScreen(scene: Scene) -> ViewType
}

extension Coordinator {
    func push(_ scene: Scene) {
        paths.append(scene)
    }
    
    func pop() {
        _ = paths.popLast()
    }
    
    func popToRoot() {
        paths.removeAll()
    }
}





