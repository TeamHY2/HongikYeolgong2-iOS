//
//  SettingView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/3/25.
//

import SwiftUI
import ComposableArchitecture

struct SettingView: View {
    let store: StoreOf<SettingFeature>
    
    var body: some View {
        Button(action: {store.send(.logoutButtonTap)}) {
            Text("로그아웃 테스트")
        }
    }
}

//#Preview {
//    SettingView()
//}
