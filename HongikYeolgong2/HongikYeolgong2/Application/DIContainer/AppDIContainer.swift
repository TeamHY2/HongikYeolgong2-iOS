//
//  AppDIContainer.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/28/25.
//

final class AppDIContainer {        
    func makeAppDIContainer() -> DIContainer {
        // 네트워크, 서비스 관련 외부 의존성주입
        let dependencies = DIContainer.Dependencies()
        return DIContainer(dependencies: dependencies)
    }
}
