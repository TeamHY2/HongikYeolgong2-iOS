//
//  ServicesContainer.swift
//  HongikYeolgong2
//
//  Created by 권석기 on 10/23/24.
//

import Foundation

extension DIContainer {
    struct Services {
        let authenticationService: AuthenticationService
        
        init(authenticationService: AuthenticationService) {
            self.authenticationService = authenticationService
        }
        
        static let `default` = Self(authenticationService: AuthenticationServiceImpl())
    }
}
