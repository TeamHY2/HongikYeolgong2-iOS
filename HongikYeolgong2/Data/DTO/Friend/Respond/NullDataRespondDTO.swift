//
//  NullDataRespondDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 12/2/25.
//

import Foundation

struct nullDataResponseDTO: Decodable {
    let code: Int
    let status: String
    let message: String
    let data: String?
}
