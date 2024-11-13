//
//  Loadable.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/12/24.
//

import Foundation
import SwiftUI

typealias LoadableSubject<Value> = Binding<Loadable<Value>>

enum Loadable<T> {
    case notRequest
    case loading
    case success(T)
    case error(NetworkError)

    var value: T? {
        switch self {
        case let .success(value): return value
        default: return nil
        }
    }
    
    mutating func setLoading() {
        self = .loading
    }
    
    mutating func setSuccess(value: T) {
        self = .success(value)
    }
    
    mutating func setError(error: NetworkError) {
        self = .error(error)
    }
}

extension Loadable {
    // 로딩 상태 확인용
    var isLoading: Bool {
        if case .loading = self { return true }
        return false
    }
    
    // 에러 상태 확인용
    var isError: Bool {
        if case .error = self { return true }
        return false
    }
}
