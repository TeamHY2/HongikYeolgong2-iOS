//
//  AppEnviroment.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import Foundation
import UIKit

struct AppEnviroment {
    var container: DIContainer
}

extension AppEnviroment {
    static func bootstrap() -> AppEnviroment {
        let appState = Store<AppState>(AppState())
        let authRepository = AuthRepositoryImpl()
        
        let services: DIContainer.Services = .init(
            authenticationService: AuthenticationServiceImpl()
        )
        
        let interactors: DIContainer.Interactors = .init(
            userDataInteractor: UserDataInteractorImpl(
                appState: appState,
                authRepository: authRepository,
                authService: services.authenticationService
            ),
            userPermissionsInteractor: RealUserPermissionsInteractor(appState: appState, openAppSetting: {
                if let url = URL(string: UIApplication.openNotificationSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            })
        )
        
        let diContainer = DIContainer(
            appState: appState,
            interactors: interactors,
            services: services
        )
        
        return .init(container: diContainer)
    }
}
