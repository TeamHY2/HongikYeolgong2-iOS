//
//  UserDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import Foundation
import SwiftUI
import Combine
import AuthenticationServices

protocol UserDataInteractor: AnyObject {
    func requestAppleLogin(_ authorization: ASAuthorization)
    func signUp(nickname: String, department: Department)
    func logout()
    func getUser()
    func checkAuthentication()
    func checkUserNickname(nickname: String, nicknameCheckSubject: CurrentValueSubject<Bool, Never>)
}

final class UserDataInteractorImpl: UserDataInteractor {
    
    private let cancleBag = CancelBag()
    private let appState: Store<AppState>
    private let authRepository: AuthRepository
    private let authService: AuthenticationService
    
    init(appState: Store<AppState>,
         authRepository: AuthRepository,
         authService: AuthenticationService) {
        self.appState = appState
        self.authRepository = authRepository
        self.authService = authService
    }
    
    ///  애플로그인을 요청합니다.
    /// - Parameter authorization: ASAuthorization
    func requestAppleLogin(_ authorization: ASAuthorization) {
        guard let (email, idToken) = authService.requestAppleLogin(authorization) else {
            return
        }
        
        let loginReqDto: LoginRequestDTO = .init(email: email, idToken: idToken)
        
        authRepository
            .signIn(loginReqDto: loginReqDto)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in},
                receiveValue: { [weak self] loginResDto in                    
                    guard let self = self else { return }
                    
                    let isAlreadyExists = loginResDto.alreadyExist
                    
                    // 회원가입 여부에 따라서 화면분기
                    if isAlreadyExists {
                        appState[\.userSession] = .authenticated
                    } else {
                        appState[\.routing.onboarding.signUp] = true
                    }
                    
                    KeyChainManager.addItem(key: .accessToken, value: loginResDto.accessToken)
                }
            )
            .store(in: cancleBag)
    }
    
    /// 회원가입을 요청합니다.
    /// - Parameters:
    ///   - nickname: 닉네임
    ///   - department: 학과
    func signUp(nickname: String, department: Department) {
        authRepository
            .signUp(signUpReqDto: .init(nickname: nickname, department: department.rawValue))
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] _ in
                    guard let self = self else { return }
                    appState[\.userSession] = .authenticated
                }
            )
            .store(in: cancleBag)
    }
    
    /// 로그아웃
    func logout() {
        appState[\.userSession] = .unauthenticated
        KeyChainManager.deleteItem(key: .accessToken)
    }
    
    /// 닉네임 중복체크
    /// - Parameters:
    ///   - nickname: 닉네임
    ///   - isValidate: 중복여부
    func checkUserNickname(nickname: String, nicknameCheckSubject: CurrentValueSubject<Bool, Never>) {
        authRepository
            .checkUserNickname(nickname: nickname)
            .replaceError(with: true)
            .receive(on: DispatchQueue.main)
            .sink { nicknameCheckSubject.send($0) }
            .store(in: cancleBag)
    }
    
    /// 로그인된 유저정보를 가져옵니다.
    func getUser() {
        authRepository
            .getUser()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self = self else { return }
                    switch completion {
                    case .finished:                    
                        appState[\.userSession] = .authenticated
                    case .failure(_):
                        appState[\.userSession] = .unauthenticated
                    }
                },
                receiveValue: { _ in }
            )
            .store(in: cancleBag)
    }
    
    /// 유저인증 상태를 체크합니다.
    func checkAuthentication() {
        authRepository
            .validToken()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case let .failure(error):
                    appState[\.userSession] = .unauthenticated
                }
            }, receiveValue: { [weak self] tokenValidRes in
                guard let self = self else { return }
                if tokenValidRes.validToken {
                    appState[\.userSession] = .authenticated
                } else {
                    appState[\.userSession] = .unauthenticated
                }
            })
            .store(in: cancleBag)
    }
}

