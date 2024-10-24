//
//  WeeklyStudyInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import Foundation

protocol StudySessionInteractor {
    func getWeekyStudy()
}

final class StudySessionInteractorImpl: StudySessionInteractor {
    private let cancleBag = CancelBag()
    private let studySessionRepository: StudySessionRepository
    
    init(studySessionRepository: StudySessionRepository) {
        self.studySessionRepository = studySessionRepository
    }
    
    func getWeekyStudy() {
        studySessionRepository.getWeelyStudy()
    }
}
