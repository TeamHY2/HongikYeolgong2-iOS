//
//  StudyRepository.swift
//  HongikYeolgong2
//
//  Created by 변정훈 on 10/22/24.
//

import Combine

protocol StudyRepository {
    func studyCountAll() -> AnyPublisher<Bool, Error>
}
