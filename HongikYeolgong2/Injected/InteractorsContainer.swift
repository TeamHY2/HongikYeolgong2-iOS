//
//  InteractorsContainer.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/11/24.
//

import Foundation

extension DIContainer {
    struct Interactors {
        let userDataInteractor: UserDataInteractor
        
        init(userDataInteractor: UserDataInteractor) {
            self.userDataInteractor = userDataInteractor
        }
    }
}
