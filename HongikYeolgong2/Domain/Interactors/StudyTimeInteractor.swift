//
//  StudyTimeInteractor.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/6/24.
//

import SwiftUI

protocol StudyTimeInteractor {
    func getStudyTime(StudyTime: LoadableSubject<StudyTime>, date: Date?)
}

final class StudyTimeInteractorImpl: StudyTimeInteractor {
    private let cancelBag = CancelBag()
    private let studySessionRepository: StudySessionRepository
    
    init(studySessionRepository: StudySessionRepository) {
        self.studySessionRepository = studySessionRepository
    }
    
    func getStudyTime(StudyTime: LoadableSubject<StudyTime>, date: Date?) {
        studySessionRepository
            .getStudyTime(date: date ?? Date())
            .sinkToLoadbleWithoutLoding(StudyTime)
            .store(in: cancelBag)
    }
}
