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
        let weeklStudyInteractor: WeeklyStudyInteractor
        
        init(userDataInteractor: UserDataInteractor, 
             weeklStudyInteractor: WeeklyStudyInteractor) {
            self.userDataInteractor = userDataInteractor
            self.weeklStudyInteractor = weeklStudyInteractor
        }
        
        static let `default` = Self(
            userDataInteractor: UserDataInteractorImpl(
                appState: Store<AppState>(AppState()),
                authRepository: AuthRepositoryImpl(),
                authService: AuthenticationServiceImpl()
            ),
            weeklStudyInteractor: WeeklyStudyInteractorImpl()
        )
    }
}
