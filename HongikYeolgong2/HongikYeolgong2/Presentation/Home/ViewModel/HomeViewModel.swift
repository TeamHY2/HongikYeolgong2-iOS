//
//  HomeViewModel.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/30/25.
//

final class HomeViewModel {
    var studyRoomUseCase: StudyRoomUseCase
    
    init(studyRoomUseCase: StudyRoomUseCase) {
        self.studyRoomUseCase = studyRoomUseCase
    }
}
