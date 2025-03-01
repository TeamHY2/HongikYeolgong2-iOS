//
//  StudyTimeMapper.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/6/24.
//

import Foundation

extension StudyTimeResponseDTO {
    func toEntity() -> StudyTime {
        .init(yearHours: yearHours,
              yearMinutes: yearMinutes,
              monthHours: monthHours,
              monthMinutes: monthMinutes,
              dayHours: dayHours,
              dayMinutes: dayMinutes)
    }
}
