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
    func signUp(nickname: String, department: Department,  loadbleSubject: LoadableSubject<Bool>)
    func logout()
    func checkAuthentication()
    func checkUserNickname(inputNickname: String, nickname: Binding<Nickname>)
    func validateUserNickname(inputNickname: String, nickname: Binding<Nickname>)
    func getUserProfile()
    func withdraw(isLoading: LoadableSubject<Bool>)
    func profileEdit(nickname: String, department: Department)
}

final class UserDataInteractorImpl: UserDataInteractor {
    func validateUserNickname(inputNickname: String, nickname: Binding<Nickname>) {
        
    }
    
    func profileEdit(nickname: String, department: Department) {
        
    }
    
    
    private let cancleBag = CancelBag()
    private let appState: Store<AppState>
    private let authRepository: AuthRepository
    private let authService: AppleLoginService
    
    init(appState: Store<AppState>,
         authRepository: AuthRepository,
         authService: AppleLoginService) {
        self.appState = appState
        self.authRepository = authRepository
        self.authService = authService
    }
    
    ///  애플로그인을 요청합니다.
    /// - Parameter authorization: ASAuthorization
    func requestAppleLogin(_ authorization: ASAuthorization) {
        guard let appleIDCredential = authService.requestAppleLogin(authorization),
              let email = appleIDCredential.email,
              let idTokenData = appleIDCredential.identityToken,
              let idToken = String(data: idTokenData, encoding: .utf8) else {
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
    func signUp(nickname: String, department: Department, loadbleSubject: LoadableSubject<Bool>) {
        authRepository
            .signUp(signUpReqDto: .init(nickname: nickname, department: department.rawValue))
            .receive(on: DispatchQueue.main)
            .sinkToLoadble(loadbleSubject) { [weak self] signUpResDto in
                guard let self = self else { return }
                appState[\.userSession] = .authenticated
                KeyChainManager.addItem(key: .accessToken, value: signUpResDto.accessToken)
            }
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
    func checkUserNickname(inputNickname: String, nickname: Binding<Nickname>) {
        authRepository
            .checkUserNickname(nickname: inputNickname)
            .replaceError(with: true)
            .receive(on: DispatchQueue.main)
            .filter { !$0 }
            .map { _ in }
            .sink { nickname.wrappedValue = .available}
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
                if tokenValidRes.role == "USER" {
                    appState[\.userSession] = .authenticated
                } else {
                    appState[\.userSession] = .unauthenticated
                }
            })
            .store(in: cancleBag)
    }
    
    func getUserProfile() {
        authRepository
            .getUserProfile()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { _ in
                
            }
            .store(in: cancleBag)
    }
    
    func withdraw(isLoading: LoadableSubject<Bool>) {
        
    }
}
