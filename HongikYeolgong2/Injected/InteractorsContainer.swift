//
//  InteractorsContainer.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import Foundation

extension DIContainer {
    struct Interactors {
        let userDataInteractor: UserDataInteractor
        let userPermissionsInteractor: UserPermissionsInteractor
        
        init(userDataInteractor: UserDataInteractor, userPermissionsInteractor: UserPermissionsInteractor) {
            self.userDataInteractor = userDataInteractor
            self.userPermissionsInteractor = userPermissionsInteractor
        }
        
        static let `default` = Self(
            userDataInteractor: UserDataInteractorImpl(
                appState: Store<AppState>(AppState()),
                authRepository: AuthRepositoryImpl(),
                authService: AuthenticationServiceImpl()
            ),
            userPermissionsInteractor: RealUserPermissionsInteractor(appState: Store<AppState>(AppState()), openAppSetting: {})
        )
    }
}
