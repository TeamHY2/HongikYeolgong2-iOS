//
//  StudyStatusMapper.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 6/17/25.
//

import Foundation

extension StudyStatusResponseDTO {
    func toEntity() -> StudyStatusInfo {
        .init(userId: userId,
              userName: userName,
              studyDuration: studyDuration,
              studyStatus: studyStatus
        )
    }
}
