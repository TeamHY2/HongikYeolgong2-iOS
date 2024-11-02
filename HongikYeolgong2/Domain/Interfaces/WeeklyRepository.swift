//
//  WeeklyRepository.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/31/24.
//

import Combine

protocol WeeklyRepository {
    func getWeekField(date: String) -> AnyPublisher<Int, NetworkError>
}
