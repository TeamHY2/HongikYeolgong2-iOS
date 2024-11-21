//
//  NetworkStateView.swift
//  HongikYeolgong2
//
//  Created by 최주원 on 11/12/24.
//

import SwiftUI

/// 네트워크 연결상태 표시 View
///  - loadables: 데이터 통신 관련갑 Loadable 값들
///  - retryAction:  데이터 받아오는 함수 (실패시 다시시도 용도) - 현재 사용 x -> 추후 기능 보완시 사용 (다시 시도)
///  - content: 기본으로 나타날 view
///
///  ```swift
/// // 값 선언 방식
/// // 기본 상태 .notRequest로 세팅
/// @State private var loadable1: Loadable<엔티티 타입> = .notRequest
/// @State private var loadable2: Loadable<엔티티 타입> = .notRequest
///
///  // 사용 예시
///  NetworkStateView(
///     // Loadable타입 데이터 입력
///     loadables: [loadable1, loadable2],
///     retryAction: loadData  // 아래 함수로 정리
///  ) {
///     // 기존 View 코드 입력
///  }
///
///  // 데이터 받아오는 코드
///  func loadData() {
///     // api 요청하는 코드 종합 관리 (다시시도 기능 추가용도)
///  }
///  ```
struct NetworkStateView<Content: View>: View {
    let loadables: [AnyLoadable]
    let retryAction: () -> Void
    let content: () -> Content
    
    // 로딩 상태 확인
    var isLoading: Bool {
        loadables.contains { $0.isLoading }
    }
    
    // 에러 상태 확인
    var isError: Bool {
        loadables.contains { $0.isError }
    }
    
    init(loadables: [AnyLoadable], retryAction: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self.loadables = loadables
        self.retryAction = retryAction
        self.content = content
    }

    var body: some View {
        ZStack {
            content()
                .disabled(isLoading || isError)
                .blur(radius: isLoading || isError ? 3 : 0)
            if isLoading {
                LoadingView()
            } else if isError {
                NetworkingErrorView(retryAction: setNotRequest)
            }
        }
    }
    
    // 기본 이용할 수 있는 상태로 변경
    func setNotRequest() {
        loadables.forEach { $0.setNotRequest() }
    }
}
