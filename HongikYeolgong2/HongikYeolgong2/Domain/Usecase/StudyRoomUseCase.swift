//
//  StudyRoomUseCase.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//

protocol StudyRoomUseCase {
    
}

final class DefaultStudyRoomUseCase: StudyRoomUseCase {
    private let studyRoomRepository: StudyRoomRepository
    
    init(studyRoomRepository: StudyRoomRepository) {
        self.studyRoomRepository = studyRoomRepository
    }
}
