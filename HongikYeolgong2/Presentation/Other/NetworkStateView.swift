//
//  NetworkStateView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/12/24.
//

import SwiftUI

/// 네트워크 연결상태 표시 View
///  - loadables: 데이터 통신 관련갑 Loadable 값들
///  - retryAction:  데이터 받아오는 함수 (실패시 다시시도 용도)
///  - content: 기본으로 나타날 view
struct NetworkStateView<T, Content: View>: View {
    let loadables: [Binding<Loadable<T>>]
    let retryAction: () -> Void
    let content: () -> Content
    
    // 로딩 상태 확인
    var isLoading: Bool {
        loadables.contains { $0.wrappedValue.isLoading }
    }
    
    // 에러 상태 확인
    var isError: Bool {
        loadables.contains { $0.wrappedValue.isError }
    }
    
    init(loadables: [Binding<Loadable<T>>], retryAction: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.loadables = loadables
        self.retryAction = retryAction
        self.content = content
    }

    var body: some View {
        ZStack {
            content()
                .disabled(isLoading || isError)
                .blur(radius: isLoading || isError ? 2 : 0)
            if isLoading {
                LoadingView()
            } else if isError {
                NetworkingErrorView()
            }
        }
    }
}
