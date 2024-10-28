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
        let studySessionInteractor: StudySessionInteractor
        let userPermissionsInteractor: UserPermissionsInteractor    
        let weeklyStudyInteractor: WeeklyStudyInteractor
        
        init(userDataInteractor: UserDataInteractor,
             studySessionInteractor: StudySessionInteractor, 
             userPermissionsInteractor: UserPermissionsInteractor, 
             weeklyStudyInteractor: WeeklyStudyInteractor) {
            
            self.userDataInteractor = userDataInteractor
            self.studySessionInteractor = studySessionInteractor
            self.userPermissionsInteractor = userPermissionsInteractor
            self.weeklyStudyInteractor = weeklyStudyInteractor
        }
        
        static let `default` = Self(
            userDataInteractor: UserDataInteractorImpl(
                appState: Store<AppState>(AppState()),
                authRepository: AuthRepositoryImpl(),
                authService: AuthenticationServiceImpl()
            ),
            studySessionInteractor: StudySessionInteractorImpl(appState: Store<AppState>(AppState()), studySessionRepository: StudySessionRepositoryImpl()),
            userPermissionsInteractor: RealUserPermissionsInteractor(appState: Store<AppState>(AppState()), openAppSetting: {}),
            weeklyStudyInteractor: WeeklyStudyInteractorImpl(appState: Store<AppState>(AppState()), studySessionRepository: StudySessionRepositoryImpl())
        )
    }
}

