//
//  UserDataInteractor+Migration.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 11/7/24.
//

import AuthenticationServices
import Combine
import CryptoKit
import SwiftUI

import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import SwiftJWT

final class UserDataMigrationInteractor: UserDataInteractor {
    
    private let cancleBag = CancelBag()
    private let appState: Store<AppState>
    private let authRepository: AuthRepository
    private let socialLoginRepository: SocialLoginRepository
    private let appleLoginService: AppleLoginService
    private let db = Firestore.firestore()
    
    init(appState: Store<AppState>,
         authRepository: AuthRepository,
         socialLoginRepository: SocialLoginRepository,
         appleLoginService: AppleLoginService) {
        self.appState = appState
        self.authRepository = authRepository
        self.appleLoginService = appleLoginService
        self.socialLoginRepository = socialLoginRepository
    }
    
    
    /// 기존 유저를 검색하고 ID를 반환합니다.
    /// - Parameter idToken: identityToken
    /// - Returns: 유저ID
    /// NOTE: - 유저를 찾지 못하는 경우 실패없이 성공을 반환하고 가입을 진행합니다.
    func findFirebaseUser(with idToken: String) -> AnyPublisher<String, Never> {
        let nonce = randomNonceString()
        return Future<String, Never> { promise in
            
            let credential = OAuthProvider.credential(
                withProviderID: "apple.com",
                idToken: idToken,
                rawNonce: nonce
            )
            
            Auth.auth().signIn(with: credential) { [weak self] (result, error) in
                guard let self = self,
                      let userId = result?.user.uid else {
                    promise(.success(""))
                    return
                }
                
                let docRef = db.collection("User").document(userId)
                
                docRef.getDocument { (document, error) in
                    guard let isDocExists = document?.exists else {
                        promise(.success(""))
                        return
                    }
                    
                    if isDocExists {
                        promise(.success(userId))
                    } else {
                        promise(.success(""))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    ///  애플로그인을 요청합니다.
    /// - Parameter authorization: ASAuthorization
    func requestAppleLogin(_ authorization: ASAuthorization) {
        guard let appleIDCredential = appleLoginService.requestAppleLogin(authorization),
              let idTokenData = appleIDCredential.identityToken,
                let idToken = String(data: idTokenData, encoding: .utf8) else {
            return
        }
        
        findFirebaseUser(with: idToken)
            .flatMap { [weak self] userID -> AnyPublisher<LoginResponseDTO, NetworkError> in
                guard let self = self else {
                    return Fail(error: NetworkError.decodingError("")).eraseToAnyPublisher()
                }
                let loginReqDto: LoginRequestDTO = .init(email: userID, idToken: idToken)
              
                return authRepository.signIn(loginReqDto: loginReqDto)
            }
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { _ in},
                receiveValue: { [weak self] loginResDto in
                     guard let self = self else { return }
                    
                    let isAlreadyExists = loginResDto.alreadyExist
                    
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
                receiveValue: { [weak self] signUpResDto in
                    guard let self = self else { return }
                    appState[\.userSession] = .authenticated
                    appState[\.routing.onboarding.signUp] = false
                    KeyChainManager.addItem(key: .accessToken, value: signUpResDto.accessToken)
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
    func checkUserNickname(inputNickname: String, nickname: Binding<Nickname>) {
        authRepository
            .checkUserNickname(nickname: inputNickname)
            .replaceError(with: true)
            .receive(on: DispatchQueue.main)
            .sink { $0 ? (nickname.wrappedValue = .alreadyUse) : (nickname.wrappedValue = .available) }
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
            .sink(receiveCompletion: { _ in }) { [weak self] userProfile in
                guard let self = self else { return }
                appState.bulkUpdate { appState in
                    appState.userData.nickname = userProfile.nickname
                    appState.userData.department = userProfile.department
                }
            }
            .store(in: cancleBag)
    }
    
    func validateUserNickname(inputNickname: String, nickname: Binding<Nickname>) {
        if inputNickname.isEmpty {
            nickname.wrappedValue = .none
        } else if inputNickname.count < 2 || inputNickname.count > 8 {
            nickname.wrappedValue = .notAllowedLength
        } else if inputNickname.contains(" ") || checkSpecialCharacter(inputNickname) {
            nickname.wrappedValue = .specialCharactersAndSpaces
        } else if checkKoreanLang(inputNickname) {
            nickname.wrappedValue = .checkAvailable
        } else {
            nickname.wrappedValue = .unknown
        }
    }
    
    func checkSpecialCharacter(_ input: String) -> Bool {
        let pattern: String = "[!\"#$%&'()*+,-./:;<=>?@[\\\\]^_`{|}~€£¥₩¢₹©®™§¶°•※≡∞≠≈‽✓✔✕✖←→↑↓↔↕↩↪↖↗↘↙ñ¡¿éèêëçäöüßàìòùåøæ]"
        
        if let _ = input.range(of: pattern, options: .regularExpression)  {
            return true
        } else {
            return false
        }
    }
    
    func checkKoreanLang(_ input: String) -> Bool {
        let pattern = "^[가-힣a-zA-Z\\s]*$"
        
        if let _ = input.range(of: pattern, options: .regularExpression)  {
            return true
        } else {
            return false
        }
    }
    
    /// 회원 탈퇴
    func withdraw() {
        let clientSecret = makeJWT()
        
        appleLoginService.performExistingAccountSetupFlows()
            .mapError({ error in
                NetworkError.decodingError("")
            })
            .flatMap({ [weak self] appleIDCrendential -> AnyPublisher<ASTokenResponseDTO, NetworkError> in
                guard let self = self,
                      let appleIDCredential = appleIDCrendential,
                      let authorizationCodeData = appleIDCredential.authorizationCode,
                      let authorizationCode = String(data: authorizationCodeData, encoding: .utf8) else {
                    return Fail(error: NetworkError.decodingError("could not decoded appleIDCredential")).eraseToAnyPublisher()
                }
                
                let asTokenRequestDto: ASTokenRequestDTO = .init(client_id: SecretKeys.bundleName,
                                                                 client_secret: clientSecret,
                                                                 grant_type: "authorization_code",
                                                                 code: authorizationCode)
                
                return socialLoginRepository.requestASToken(asTokenRequestDto: asTokenRequestDto)
            })
            .flatMap({ [weak self] asTokenResponseDto -> AnyPublisher<Void, NetworkError> in
                guard let self = self else {
                    return Fail(outputType: Void.self, failure: NetworkError.decodingError("")).eraseToAnyPublisher()
                }
                
                let asRevokeTokenRequestDto: ASRevokeTokenRequestDTO = .init(
                    client_id: SecretKeys.bundleName,
                    client_secret: clientSecret,
                    token: asTokenResponseDto.accessToken,
                    token_type_hint: "")
                
                return self.socialLoginRepository.requestASTokenRevoke(asRevokeTokenRequestDto: asRevokeTokenRequestDto)
            })
            .flatMap({ [weak self] _ in
                guard let self = self else {
                    return Fail(outputType: Void.self, failure: NetworkError.decodingError("")).eraseToAnyPublisher()
                }
                return authRepository.withdraw()
            })
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { [weak self] in
                guard let self = self else { return }
                appState.bulkUpdate { appState in
                    appState.userSession = .unauthenticated
                    appState.userData = .init()
                    appState.permissions = .init()
                    appState.studySession = .init()
                    appState.system = .init()
                }
                KeyChainManager.deleteItem(key: .accessToken)
            })
            .store(in: cancleBag)
    }
}

extension UserDataMigrationInteractor {
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    func makeJWT() -> String {
        let myHeader = Header(kid: SecretKeys.serviceID)
        struct MyClaims: Claims {
            let iss: String
            let iat: Int
            let exp: Int
            let aud: String
            let sub: String
        }
        
        let iat = Int(Date().timeIntervalSince1970)
        let exp = iat + 3600
        let myClaims = MyClaims(iss: SecretKeys.teamID,
                                iat: iat,
                                exp: exp,
                                aud: "https://appleid.apple.com",
                                sub: SecretKeys.bundleName)
        
        var myJWT = JWT(header: myHeader, claims: myClaims)
        
        guard let url = Bundle.main.url(forResource: "AuthKey_\(SecretKeys.serviceID)", withExtension: "p8") else {
            return ""
        }
        
        let privateKey: Data = try! Data(contentsOf: url, options: .alwaysMapped)
        
        let jwtSigner = JWTSigner.es256(privateKey: privateKey)
        let signedJWT = try! myJWT.sign(using: jwtSigner)
        
        return signedJWT
    }
    
}
