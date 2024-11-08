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
        let studyTimeInteractor: StudyTimeInteractor
        let studySessionInteractor: StudySessionInteractor
        let userPermissionsInteractor: UserPermissionsInteractor    
        let weeklyStudyInteractor: WeeklyStudyInteractor
        let rankingDataInteractor: RankingDataInteractor
        
        init(userDataInteractor: UserDataInteractor,
             studyTimeInteractor: StudyTimeInteractor,
             studySessionInteractor: StudySessionInteractor,
             userPermissionsInteractor: UserPermissionsInteractor,
             weeklyStudyInteractor: WeeklyStudyInteractor, 
             rankingDataInteractor: RankingDataInteractor) {
            
            self.userDataInteractor = userDataInteractor
            self.studyTimeInteractor = studyTimeInteractor
            self.studySessionInteractor = studySessionInteractor
            self.userPermissionsInteractor = userPermissionsInteractor
            self.weeklyStudyInteractor = weeklyStudyInteractor
            self.rankingDataInteractor = rankingDataInteractor
        }
        
        static let `default` = Self(
            userDataInteractor: UserDataInteractorImpl(
                appState: Store<AppState>(AppState()),
                authRepository: AuthRepositoryImpl(),
                authService: AuthenticationServiceImpl()
            ),
            studyTimeInteractor: StudyTimeInteractorImpl(studySessionRepository: StudySessionRepositoryImpl()),
            studySessionInteractor: StudySessionInteractorImpl(appState: Store<AppState>(AppState()), studySessionRepository: StudySessionRepositoryImpl()),
            userPermissionsInteractor: RealUserPermissionsInteractor(appState: Store<AppState>(AppState()), openAppSetting: {}),
            weeklyStudyInteractor: WeeklyStudyInteractorImpl(appState: Store<AppState>(AppState()), studySessionRepository: StudySessionRepositoryImpl()),
            rankingDataInteractor: RankingDataInteractorImpl(studySessionRepository: StudySessionRepositoryImpl(), weeklyRepository: WeeklyRepositoryImpl())
        )
    }
}

