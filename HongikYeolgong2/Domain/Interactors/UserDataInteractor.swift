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
    func signUp(nickname: String, department: Department)
    func logout()
    func getUser()
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
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in}
                  , receiveValue: { [weak self] loginResDto in
                guard let self = self else { return }
                
                appState[\.userData.isLoggedIn] = loginResDto.alreadyExist
                appState[\.appLaunchState] = loginResDto.alreadyExist ? .authenticated : .notAuthenticated
                appState[\.routing.onboarding.signUp] = true
                KeyChainManager.addItem(key: .accessToken, value: loginResDto.accessToken)
            })
            .store(in: cancleBag)
    }
    
    func signUp(nickname: String, department: Department) {
        authRepository
            .signUp(signUpReqDto: .init(nickname: nickname, department: department.rawValue))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in},
                  receiveValue: { [weak self] signUpResDto in
                guard let self = self else { return }
                appState[\.appLaunchState] = .authenticated
            })
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
    
    func getUser() {
        authRepository
            .getUser()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    appState[\.appLaunchState] = .authenticated
                case let .failure(error):
                    appState[\.appLaunchState] = .notAuthenticated
                }
            }
    receiveValue: { _ in }
            .store(in: cancleBag)
    }
}
