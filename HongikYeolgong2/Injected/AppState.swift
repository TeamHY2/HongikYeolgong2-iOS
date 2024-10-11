//
//  AppState.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import SwiftUI

final class AppState: ObservableObject {
    @Published var userData = UserData()
    @Published var viewRouting = ViewRouting()
}

extension AppState {
    struct UserData: Equatable {        
        var isLoggedIn = false
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        
    }
}
