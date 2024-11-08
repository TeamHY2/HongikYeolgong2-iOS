//
//  StudyTimeInteractor.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/6/24.
//

import SwiftUI

protocol StudyTimeInteractor {
    func getStudyTime(StudyTime: Binding<StudyTime>)
}

final class StudyTimeInteractorImpl: StudyTimeInteractor {
    private let cancleBag = CancelBag()
    private let studySessionRepository: StudySessionRepository
    
    init(studySessionRepository: StudySessionRepository) {
        self.studySessionRepository = studySessionRepository
    }
    
    func getStudyTime(StudyTime: Binding<StudyTime>) {
        studySessionRepository
            .getStudyTime()
            .sink { _ in
            } receiveValue: {
                StudyTime.wrappedValue = $0
            }
            .store(in: cancleBag)

    }
}
