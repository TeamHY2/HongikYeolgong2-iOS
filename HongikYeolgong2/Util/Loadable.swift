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

/// Loadable 타입 소거 구조체
/// 각 제네릭 타입에 대응하기 위해 타입 소거하고, 상타값만 전달하는 방식으로 지정
/// - NetworkStateView에서는 값 상관없이 해당 상태만 관측하면 되기에 해당 방식 이용
/// - 각 제네릭 타입에 대응하기 위한 수단
struct AnyLoadable {
    private let _isLoading: () -> Bool
    private let _isError: () -> Bool
    private let _setNotRequest: () -> Void

    init<T>(_ loadable: Binding<Loadable<T>>) {
        _isLoading = { loadable.wrappedValue.isLoading }
        _isError = { loadable.wrappedValue.isError }
        _setNotRequest = { loadable.wrappedValue = .notRequest }
    }

    var isLoading: Bool { _isLoading() }
    var isError: Bool { _isError() }
    func setNotRequest() { _setNotRequest() }
}
