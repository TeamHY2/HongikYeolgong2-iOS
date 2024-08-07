

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case checkAuthenticationState
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
        case logOut
//        case deleteAppleAccount
    }
    
    @Published var authenticationState: AuthenticationState = .unauthenticated
    
    var userID: String?
    
    private var currentNonce: String?
    private var subscriptions = Set<AnyCancellable>()
    
    // Dependency
    @Inject private var authService: AuthenticationServiceType
    
    init() {}
    
    func send(action: Action) {
        switch action {
        case .checkAuthenticationState:
            if let userID = authService.checkAuthenticationState() {
                self.userID = userID
                self.authenticationState = .authenticated
            }
        case .appleLogin(let aSAuthorizationAppleIDRequest):
            let nonce = authService.handleSignInWithAppleRequest(aSAuthorizationAppleIDRequest)
            currentNonce = nonce
        case .appleLoginCompletion(let result):
            if case let .success(authentication) = result {
                guard let nonce = currentNonce else {return}
                authService.handleSignInWithAppleCompletion(authentication, none: nonce)
                    .sink { completon in
                        if case .failure(_) = result {
                            // TODO: 로딩 실패시 로직
                        }
                    } receiveValue: { [weak self] user in
                        self?.userID = user.id
                        self?.authenticationState = .authenticated
                    }.store(in: &subscriptions)
            } else if case let .failure(error) = result {
                print(error.localizedDescription)
            }
        case .logOut:
            authService.logOut()
                .sink { completion in
                    
                } receiveValue: { [weak self] _ in
                    self?.authenticationState = .unauthenticated
                    self?.userID = nil
                }.store(in: &subscriptions)
        }
    }
}
