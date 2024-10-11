//
//  UserDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import Foundation

protocol UserDataInteractor: AnyObject {
    func checkLoginStatus()
}

final class UserDataInteractorImpl: UserDataInteractor {
    let appState: Store<AppState>
    
    init(appState: Store<AppState>) {
        self.appState = appState
    }
    
    func checkLoginStatus() {        
        appState.value.userData.isLoggedIn = true
    }
}
