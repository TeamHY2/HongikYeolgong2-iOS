//
//  LoginView.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 1/3/25.
//

import SwiftUI
import ComposableArchitecture

struct LoginView: View {
    let store: StoreOf<LoginFeature>
    var body: some View {
        Button(action: {
            store.send(.loginButtonTap)
        }, label: {
            Text("로그인")
        })
    }
}

//#Preview {
//    LoginView()
//}
