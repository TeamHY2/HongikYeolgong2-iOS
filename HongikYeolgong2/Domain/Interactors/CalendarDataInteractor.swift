
import SwiftUI

protocol CalendarDataInteractor {
    func getAllStudy(studyRecords: LoadableSubject<[AllStudyRecord]>)
}


final class CalendarDataInteractorImpl: CalendarDataInteractor {
    private let appstate: Store<AppState>
    private let cancleBag = CancelBag()
    private let studySessionRepository: StudySessionRepository
    
    init(appstate: Store<AppState>, studySessionRepository: StudySessionRepository) {
        self.appstate = appstate
        self.studySessionRepository = studySessionRepository
    }
    
    func getAllStudy(studyRecords: LoadableSubject<[AllStudyRecord]>) {
        studySessionRepository
            .getAllStudyRecords()
            .receive(on: DispatchQueue.main)
            .sinkToLoadble(studyRecords)
            .store(in: cancleBag)
    }
}
