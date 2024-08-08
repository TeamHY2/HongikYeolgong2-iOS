

import Foundation
import Combine
import AuthenticationServices

enum AuthenticationState {
    case unauthenticated
    case authenticated
    case none
}

class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case checkAuthenticationState
        case appleLogin(ASAuthorizationAppleIDRequest)
        case appleLoginCompletion(Result<ASAuthorization, Error>)
    }
    
    @Published var authenticationState: AuthenticationState = .none
    @Published var user: User?
    
    private var currentNonce: String?
    private var subscriptions = Set<AnyCancellable>()
    
    // Dependency
    @Inject private var authService: AuthenticationServiceType
    @Inject private var userRepository: UserRepositoryType
    
    init() {}
    
    func send(action: Action) {
        switch action {
        case .checkAuthenticationState:
            checkAuthenticationState()
        case .appleLogin(let asAuthorizationAppleIDRequest):
            setCurrentNonce(asAuthorizationAppleIDRequest)
        case .appleLoginCompletion(let result):
            setUser(result)
        }
    }
}

extension AuthenticationViewModel {
    
    func checkAuthenticationState() {
        print("유저정보 확인")
        guard let email = authService.checkAuthenticationState() else {
            authenticationState = .unauthenticated
            return
        }
        
        userRepository.fetchUser(with: email)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in                
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure( _):
                    authenticationState = .unauthenticated
                }
            } receiveValue: { [weak self] user in
                guard let self = self else { return }
                self.user = user
                self.authenticationState = .authenticated
            }
            .store(in: &subscriptions)
    }
    
    func setCurrentNonce(_ asAuthorizationAppleIDRequest: ASAuthorizationAppleIDRequest) {
        let nonce = authService.handleSignInWithAppleRequest(asAuthorizationAppleIDRequest)
        currentNonce = nonce
    }
    
    // 유저정보가 있다면 기존의 유저정보를 가져온다
    // 유저정보가 없다면 db에 유저정보를 추가한다
    func setUser(_ result: Result<ASAuthorization, Error>) {
        if case let .success(authentication) = result {
            guard let nonce = currentNonce else {return}
            
            authService.handleSignInWithAppleCompletion(authentication, none: nonce)
                .withUnretained(self)
                // 유저정보를 이용하여 새로운 비동기요청
                .flatMap { (owner, user) -> AnyPublisher<User, Never> in
                    let newUser = User(id: user.id,
                                       nickname: "열공이",
                                       email: user.email)
                    
                    return owner.userRepository.createUser(newUser)
                }
                .receive(on: DispatchQueue.main)
                .sink { _ in
                    // 성공, 실패 분기처리
                } receiveValue: { [weak self] userInfo in
                    guard let self = self else { return }
                    self.user = user
                    self.authenticationState = .authenticated
                }
                .store(in: &subscriptions)
            
        } else if case let .failure(error) = result {
            print(error.localizedDescription)
        }
    }
}
