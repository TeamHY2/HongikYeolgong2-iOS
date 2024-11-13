//
//  StudyTimeInteractor.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/6/24.
//

import SwiftUI

protocol StudyTimeInteractor {
    func getStudyTime(StudyTime: LoadableSubject<StudyTime>)
}

final class StudyTimeInteractorImpl: StudyTimeInteractor {
    private let cancleBag = CancelBag()
    private let studySessionRepository: StudySessionRepository
    
    init(studySessionRepository: StudySessionRepository) {
        self.studySessionRepository = studySessionRepository
    }
    
    func getStudyTime(StudyTime: LoadableSubject<StudyTime>) {
        // 로딩상태로 수정
        StudyTime.wrappedValue.setLoading()
        studySessionRepository
            .getStudyTime()
            .sinkToLoadable(StudyTime, cancelBag: cancleBag)
    }
}
