//
//  PromotionData.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 12/4/24.
//

import SwiftUI

struct PromotionData {
    let imageUrl: String
    let detailUrl: String
    let endDate: String
    let startDate: String
    var image: UIImage?
    
    init() {
        imageUrl = ""
        detailUrl = ""
        endDate = ""
        startDate = ""
        image = nil
    }
    
    init (promtionData: PromotionResponseDTO, image: UIImage) {
        self.imageUrl = promtionData.imageUrl
        self.detailUrl = promtionData.detailUrl
        self.endDate = promtionData.endDate
        self.startDate = promtionData.startDate
        self.image = image
    }
}
