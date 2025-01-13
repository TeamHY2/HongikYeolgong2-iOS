//
//  AuthClient.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 1/7/25.
//

import Foundation
import Dependencies

struct AuthClient {
    var requestSignIn: () async throws -> (identityToken: String, email: String)
    var checkEmailExist: (String) async throws -> Bool
}

extension AuthClient: DependencyKey {
    static let liveValue = Self(
        requestSignIn: {
            return try await AppleLoginManager().requestSignIn()
        },
        checkEmailExist: { accessToken in
            let baseUrl = Bundle.main.infoDictionary?["BaseURL"] as? String ?? ""
            let urlString = "\(baseUrl)/auth/login-apple"
            guard let url = URL(string: urlString) else {
                // 이후 에러처리 추가
                return false
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let loginReqDto = LoginRequestDTO(email: "", idToken: accessToken)
            
            let jsonData = try JSONEncoder().encode(loginReqDto)
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                // 이후 에러처리 추가
                return false
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                // 서버 응답 데이터 처리
//                let responseDto = try decoder.decode(BaseResponse<LoginResponseDTO>.self, from: data)
                let responseDto: BaseResponse<LoginResponseDTO> = try await APIManager.shared.performRequest(endPoint: AuthEndpoint.loginTest)
                
                return true
            } catch {
                // 이후 에러처리 추가
                print(error.localizedDescription, "실패!")
                return false
            }
        }
    )
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}

struct LoginRequestDTO: Encodable {
    let email: String
    let idToken: String
}

struct LoginResponseDTO: Decodable {
    let accessToken: String
    let alreadyExist: Bool
}

