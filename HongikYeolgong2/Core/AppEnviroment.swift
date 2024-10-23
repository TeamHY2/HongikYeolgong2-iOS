//
//  AppEnviroment.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import Foundation

struct AppEnviroment {
    var container: DIContainer
}

extension AppEnviroment {
    static func bootstrap() -> AppEnviroment {
        let appState = Store<AppState>(AppState())
        let authRepository = AuthRepositoryImpl()
        let interactors: DIContainer.Interactors = .init(userDataInteractor: UserDataInteractorImpl(appState: appState, authRepository: authRepository))
        let services: DIContainer.Services = .init(authenticationService: AuthenticationServiceImpl())
        let diContainer = DIContainer(appState: appState, interactors: interactors, services: services)
        return .init(container: diContainer)
    }
}
