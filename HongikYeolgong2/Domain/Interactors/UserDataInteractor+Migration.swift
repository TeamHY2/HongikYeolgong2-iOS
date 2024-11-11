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
    
    ///  애플로그인을 요청합니다.
    /// - Parameter authorization: ASAuthorization
    func requestAppleLogin(_ authorization: ASAuthorization) {
        guard let appleIDCredential = appleLoginService.requestAppleLogin(authorization),
              let idTokenData = appleIDCredential.identityToken,
              let idToken = String(data: idTokenData, encoding: .utf8) else {
            return
        }
        
        // nonce 생성
        let nonce = randomNonceString()
        // credential 생성
        let credential = OAuthProvider.credential(
            withProviderID: "apple.com",
            idToken: idToken,
            rawNonce: nonce
        )
        
        var uid: String = ""
        
        // credential로 로그인 요청
        Auth.auth().signIn(with: credential) { [weak self] (result, error) in
            guard let self = self,
                  let userId = result?.user.uid else { return }
            
            let docRef = db.collection("User").document(userId)
            
            docRef.getDocument { (document, error) in
                guard error == nil else { return }
                
                guard let isDocExists = document?.exists else { return }
                
                if isDocExists {
                    uid = userId
                }
            }
        }
        
        let loginReqDto: LoginRequestDTO = .init(email: uid, idToken: idToken)
        
        authRepository
            .signIn(loginReqDto: loginReqDto)
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
                if tokenValidRes.role == "USER" {
                    appState[\.userSession] = .authenticated
                } else {
                    appState[\.userSession] = .unauthenticated
                }
            })
            .store(in: cancleBag)
    }
    
    func getUserProfile(userProfile: Binding<UserProfile>) {
        authRepository
            .getUserProfile()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) {
                userProfile.wrappedValue = $0
            }
            .store(in: cancleBag)
    }
    
    func withdraw() {
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
                
                let clientSecret = makeJWT()
                
                let asTokenRequestDTO: ASTokenRequestDTO = .init(client_id: SecretKeys.bundleName,
                                                                 client_secret: clientSecret,
                                                                 grant_type: "authorization_code",
                                                                 code: authorizationCode)
                
                return socialLoginRepository.requestASToken(asTokenRequestDto: asTokenRequestDTO)
            })           
            .sink(receiveCompletion: { _ in
                
            }, receiveValue: { _ in
                
            })
            .store(in: cancleBag)
        
        
        //        authRepository
        //            .withdraw()
        //            .sink(receiveCompletion: { _ in }) { [weak self] in
        //                guard let self = self else { return }
        //                appState.bulkUpdate { appState in
        //                    appState.userSession = .unauthenticated
        //                    appState.userData = .init()
        //                    appState.permissions = .init()
        //                    appState.studySession = .init()
        //                    appState.system = .init()
        //                }
        //                KeyChainManager.deleteItem(key: .accessToken)
        //            }
        //            .store(in: cancleBag)
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
