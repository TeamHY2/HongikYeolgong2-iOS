//
//  BaseResponse.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/14/24.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    let code: Int
    let status: String
    let message: String
    let data: T?
    
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
        self.data = try container.decodeIfPresent(T.self, forKey: BaseResponse<T>.CodingKeys.data)
    }
}
