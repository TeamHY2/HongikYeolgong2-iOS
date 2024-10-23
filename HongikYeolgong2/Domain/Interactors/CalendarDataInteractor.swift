//
//  CalendarDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 변정훈 on 10/23/24.
//

import Foundation
import Combine

protocol CalendarDataInteractor: AnyObject {
    func fetchStudyRoomRecords(for date: Date, uid: String)
}

final class CalendarDataInteractorImpl: CalendarDataInteractor {
    
    private let cancleBag = CancelBag()
    private let studyRepository: StudyRepository
    
    init(studyRepository: StudyRepository) {
        self.studyRepository = studyRepository
    }
    
    func fetchStudyRoomRecords(for date: Date, uid: String) {
        
        studyRepository
            .studyCountAll()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { _ in })
            .store(in: cancleBag)
    }
}
