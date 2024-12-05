//
//  PromotionResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 12/4/24.
//

import Foundation

struct PromotionResponseDTO: Decodable {
    let imageUrl: String
    let detailUrl: String
    let endDate: String
    let startDate: String
}
