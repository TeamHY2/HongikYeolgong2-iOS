//
//  Publisher.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/14/24.
//

import Combine


extension Publisher {
    /// Loadable타입 전용 sink
    /// - 통신 상태에 따라 상태값 관리
    func sinkToLoadable<T>(
        _ loadableSubject: LoadableSubject<T>,
        cancelBag: CancelBag
    ) {
        loadableSubject.wrappedValue.setLoading()
        
        self.sink { completion in
            switch completion {
            case .failure(let error):
                    loadableSubject.wrappedValue.setError(error: error as! NetworkError)
            case .finished:
                break
            }
        } receiveValue: { value in
            loadableSubject.wrappedValue.setSuccess(value: value as! T)
        }
        .store(in: cancelBag)
    }
}
