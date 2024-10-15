//
//  UserDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import Foundation
import Combine

protocol UserDataInteractor: AnyObject {
    func login(idToken: String)
    func logout()
}

final class UserDataInteractorImpl: UserDataInteractor {
    
    private let cancleBag = CancelBag()
    private let appState: Store<AppState>
    private let authRepository: AuthRepository
    
    init(appState: Store<AppState>, authRepository: AuthRepository) {
        self.appState = appState
        self.authRepository = authRepository
    }
    
    func login(idToken: String) {
        
        let loginReqDto: LoginRequestDTO = .init(socialPlatform: SocialLoginType.apple.rawValue, idToken: idToken)
        
        authRepository
            .signIn(loginReqDto: loginReqDto)
            .sink(receiveCompletion: { _ in },
                  receiveValue: { _ in })
            .store(in: cancleBag)
    }
    
    func logout() {
        appState[\.appLaunchState] = .notAuthenticated
    }
}
