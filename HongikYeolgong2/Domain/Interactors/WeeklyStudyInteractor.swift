//
//  WeeklyStudyInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/28/24.
//

import SwiftUI

protocol WeeklyStudyInteractor {
    func getWeekyStudy(studyRecords: LoadableSubject<[WeeklyStudyRecord]>)
    func getWiseSaying(wiseSaying: LoadableSubject<WiseSaying>)
}

final class WeeklyStudyInteractorImpl: WeeklyStudyInteractor {
    private let appState: Store<AppState>
    private let cancleBag = CancelBag()
    private let studySessionRepository: StudySessionRepository
    
    init(appState: Store<AppState>, 
         studySessionRepository: StudySessionRepository) {
        self.appState = appState
        self.studySessionRepository = studySessionRepository
    }
    
    func getWeekyStudy(studyRecords: LoadableSubject<[WeeklyStudyRecord]>) {
        studySessionRepository
            .getWeeklyStudyRecords()
            .receive(on: DispatchQueue.main)
            .sinkToLoadble(studyRecords)
            .store(in: cancleBag)
    }
    
    func getWiseSaying(wiseSaying: LoadableSubject<WiseSaying>) {
        studySessionRepository
            .getWiseSaying()
            .sinkToLoadble(wiseSaying)
            .store(in: cancleBag)
    }
}
