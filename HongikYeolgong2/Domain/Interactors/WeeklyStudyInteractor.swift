//
//  WeeklyStudyInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/28/24.
//

import SwiftUI

protocol WeeklyStudyInteractor {
    func getWeekyStudy(studyRecords: Binding<[WeeklyStudyRecord]>)
    func getWiseSaying(wiseSaying: Binding<WiseSaying>)
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
    
    func getWeekyStudy(studyRecords: Binding<[WeeklyStudyRecord]>) {
        studySessionRepository
            .getWeeklyStudyRecords()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) {
                studyRecords.wrappedValue = $0
            }
            .store(in: cancleBag)
    }
    
    func getWiseSaying(wiseSaying: Binding<WiseSaying>) {
        studySessionRepository
            .getWiseSaying()
            .sink { _ in
            } receiveValue: { 
                wiseSaying.wrappedValue = $0
            }
            .store(in: cancleBag)
    }
}
