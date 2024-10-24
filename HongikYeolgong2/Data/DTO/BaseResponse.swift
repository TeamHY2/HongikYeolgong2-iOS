//
//  BaseResponse.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation

/// 네트워크 기본응답 형식을 정의하는 제네릭 구조체 입니다.
/// 제네릭 타입은 Decodable 프로토콜을 준수 ->  BaseResponse<T:Decodable> = try await NetworkManager.request()
struct BaseResponse<T: Decodable>: Decodable {
    let code: Int
    let status: String
    let message: String
    let data: T
    
    enum CodingKeys: CodingKey {
        case code
        case status
        case message
        case data
    }
    
    init(from decoder: any Decoder) throws {
        let container: KeyedDecodingContainer<BaseResponse<T>.CodingKeys> = try decoder.container(keyedBy: BaseResponse<T>.CodingKeys.self)
        self.code = try container.decode(Int.self, forKey: BaseResponse<T>.CodingKeys.code)
        self.status = try container.decode(String.self, forKey: BaseResponse<T>.CodingKeys.status)
        self.message = try container.decode(String.self, forKey: BaseResponse<T>.CodingKeys.message)
        self.data = try container.decodeIfPresent(T.self, forKey: BaseResponse<T>.CodingKeys.data)!
    }
}
