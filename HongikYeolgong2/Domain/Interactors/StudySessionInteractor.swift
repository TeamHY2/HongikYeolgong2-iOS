//
//  WeeklyStudyInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/24/24.
//

import SwiftUI

protocol StudySessionInteractor {
    func getWeekyStudy(studyRecords: Binding<[WeeklyStudyRecord]>)
}

final class StudySessionInteractorImpl: StudySessionInteractor {
    private let cancleBag = CancelBag()
    private let studySessionRepository: StudySessionRepository
    
    init(studySessionRepository: StudySessionRepository) {
        self.studySessionRepository = studySessionRepository
    }
    
    func getWeekyStudy(studyRecords: Binding<[WeeklyStudyRecord]>) {
        studySessionRepository
            .getWeelyStudy()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) {
                studyRecords.wrappedValue = $0.map { $0.toEntity() }
            }
            .store(in: cancleBag)
    }
}
