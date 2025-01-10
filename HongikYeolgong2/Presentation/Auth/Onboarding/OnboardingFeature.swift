//
//  OnboardingFeature.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/4/25.
//

import Foundation
import ComposableArchitecture
import AuthenticationServices

@Reducer
struct OnboardingFeature {
    @ObservableState
    // MARK: - State
    struct State: Equatable {
        var isLoading: Bool = false
        var tabIndex: Int = 0
        var showHomeView: Bool = false
        var showSignUpView: Bool = false
        var error: String?
    }
    // MARK: - Action
    enum Action {
        // 인덱스 변경
        case setTabIndex(Int)
        // 애플 로그인 관련 이벤트
        case appleLoginButtonTapped
        case appleLoginResponse(Result<(identityToken: String, email: String), Error>)
        case checkUserResponse(Result<(Bool), Error>)
        case setNavigation(tag: String?, isActive: Bool)
    }
    // MARK: - Dependency
    @Dependency(\.authClient) var AuthClient
    
    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                    // 인덱스 값 변경
                case .setTabIndex(let index):
                    state.tabIndex = index
                    return .none
                    
                    // 애플 로그인 버튼 클릭
                case .appleLoginButtonTapped:
                    state.isLoading = true
                    return .run { send in
                        do {
                            let result = try await AuthClient.requestSignIn()
                            await send(.appleLoginResponse(.success(result)))
                        } catch {
                            await send(.appleLoginResponse(.failure(error)))
                        }
                    }
                    
                    // 로그인 성공
                case let .appleLoginResponse(.success(result)):
                    return .run { [identityToken = result.identityToken, email = result.email] send in
                        do {
                            // 키체인 등록
                            KeyChainManager.addItem(key: .accessToken, value: identityToken)
                            // 기존 회원 여부 확인
                            let userCheckResult = try await AuthClient.checkEmailExist(identityToken)
                            await send(.checkUserResponse(.success(userCheckResult)))
                        } catch {
                            await send(.checkUserResponse(.failure(error)))
                        }
                    }
                    
                    // 로그인 실패
                case let .appleLoginResponse(.failure(error)):
                    state.isLoading = false
                    state.error = error.localizedDescription
                    return .none
                    
                    // 기존 회원 확인
                case let .checkUserResponse(.success(result)):
                    state.isLoading = false
                    if result {
                        return .send(.setNavigation(tag: "home", isActive: true))
                    } else {
                        return .send(.setNavigation(tag: "signUp", isActive: true))
                    }
                    
                    // 기존 회원 확인 실패
                case let .checkUserResponse(.failure(error)):
                    state.isLoading = false
                    state.error = error.localizedDescription
                    return .none
                    
                    // 화면 이동
                case let .setNavigation(tag, isActive):
                    switch tag {
                        case "home":
                            state.showHomeView = isActive
                        case "signUp":
                            state.showSignUpView = isActive
                        default: break
                    }
                    return .none
            }
        }
    }
}
