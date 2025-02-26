
import SwiftUI

protocol CalendarDataInteractor {
    func getAllStudy(studyRecords: Binding<[AllStudyRecord]>)
}


final class CalendarDataInteractorImpl: CalendarDataInteractor {
    private let appstate: Store<AppState>
    private let cancleBag = CancelBag()
    private let studySessionRepository: StudySessionRepository
    
    init(appstate: Store<AppState>, studySessionRepository: StudySessionRepository) {
        self.appstate = appstate
        self.studySessionRepository = studySessionRepository
    }
    
    func getAllStudy(studyRecords: Binding<[AllStudyRecord]>) {
        studySessionRepository
            .getAllStudyRecords()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) {
                studyRecords.wrappedValue = $0
            }
            .store(in: cancleBag)
    }
}
