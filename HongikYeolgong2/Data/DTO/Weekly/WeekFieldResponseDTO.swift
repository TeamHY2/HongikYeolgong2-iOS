//
//  WeekFieldResponseDTO.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import Foundation

/// 날짜기준 주차 정보를 받아옵니다
/// weekNumber를 제외한 필드는 삭제예정
struct WeekFieldResponseDTO: Decodable {    
    let weekNumber: Int
}
