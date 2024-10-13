//
//  UserDataInteractor.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import Foundation
import Combine

protocol UserDataInteractor: AnyObject {
    func login()
    func logout()
}

final class UserDataInteractorImpl: UserDataInteractor {
    let appState: Store<AppState>
    let cancleBag = CancelBag()
    
    init(appState: Store<AppState>) {
        self.appState = appState
    }
    
    func login() {
        appState[\.appLaunchState] = .authenticated
    }
    
    func logout() {
        appState[\.appLaunchState] = .notAuthenticated
    }
}
