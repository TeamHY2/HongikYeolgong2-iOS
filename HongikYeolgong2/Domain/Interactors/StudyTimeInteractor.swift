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
            .sink { completion in
                switch completion {
                    case .failure(let error):
                        // 에러 처리
                        StudyTime.wrappedValue.setError(error: error)
                    case .finished:
                        break
                }
            } receiveValue: {
                // 데이터 전달 및 상태 변경
                StudyTime.wrappedValue.setSuccess(value: $0)
            }
            .store(in: cancleBag)

    }
}
