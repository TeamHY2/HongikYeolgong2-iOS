//
//  UserDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import Foundation
import SwiftUI
import Combine

protocol UserDataInteractor: AnyObject {
    func login(email: String, idToken: String)
    func logout()
    func checkUserNickname(nickname: String, isValidate: Binding<Bool>)
}

final class UserDataInteractorImpl: UserDataInteractor {
    
    private let cancleBag = CancelBag()
    private let appState: Store<AppState>
    private let authRepository: AuthRepository
    
    init(appState: Store<AppState>, authRepository: AuthRepository) {
        self.appState = appState
        self.authRepository = authRepository
    }
    
    func login(email: String, idToken: String) {
        
        let loginReqDto: LoginRequestDTO = .init(email: email, idToken: idToken)
        
        authRepository
            .signIn(loginReqDto: loginReqDto)
            .replaceError(with: false)
            .sink  { _ in }
            .store(in: cancleBag)
    }
    
    func logout() {
        appState[\.appLaunchState] = .notAuthenticated
    }
    
    func checkUserNickname(nickname: String, isValidate: Binding<Bool>) {
        authRepository
            .checkUserNickname(nickname: nickname)
            .replaceError(with: false)
            .sink { isValidate.wrappedValue = $0 }
            .store(in: cancleBag)
    }
}
