//
//  Data+.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/13/25.
//

import Foundation
import Alamofire

extension Data {
    func decode<Item: Decodable, Decoder: DataDecoder>(type: Item.Type, decoder: Decoder = JSONDecoder()) throws -> Item {
        try decoder.decode(type, from: self)
    }
}
