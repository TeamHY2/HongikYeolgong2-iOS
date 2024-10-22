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
    func login(email: String, idToken: String, isNavigation: Binding<Bool>)
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
    
    func login(email: String, idToken: String, isNavigation: Binding<Bool>) {
        
        let loginReqDto: LoginRequestDTO = .init(email: email, idToken: idToken)
        
        authRepository
            .signIn(loginReqDto: loginReqDto)
            .replaceError(with: false)
            .receive(on: DispatchQueue.main)            
            .sink { [weak self] in
                guard let self = self else { return }
                appState[\.userData.isLoggedIn] = $0
                appState[\.appLaunchState] = $0 ? .authenticated : .notAuthenticated
                $0 ? (isNavigation.wrappedValue = false) : (isNavigation.wrappedValue = true)
            }
            .store(in: cancleBag)
    }
    
    func logout() {
        appState[\.appLaunchState] = .notAuthenticated
    }
    
    func checkUserNickname(nickname: String, isValidate: Binding<Bool>) {
        authRepository
            .checkUserNickname(nickname: nickname)
            .replaceError(with: false)
            .receive(on: DispatchQueue.main)
            .sink { isValidate.wrappedValue = $0 }
            .store(in: cancleBag)
    }
}
